import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tunder/Model/token.dart';
import 'package:tunder/repository/i_connexion_repository.dart';
import 'package:http/http.dart' as http;

import '../Model/environment.dart';

class ConnexionRepository implements IConnexionRepository {
  static final String apiUrl = Environment.apiUrl;
  @override
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => fecthSigninGoogle(value.user));
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future logout() async {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  Future fetchLogin(String username, String password) async {
    var data = jsonEncode({"username": username, "password": password});
    var headers = {"Content-Type": "application/json"};
    final response = await http.post(Uri.parse('${apiUrl}/Auth/token'),
        headers: headers, body: data);
    if (response.statusCode == 200) {
      //final json = jsonDecode(response.body);
      return response.body;
    } else {
      debugPrint('response : $response');
      return null;
    }
  }

  Future fecthSigninGoogle(User? currentUser) async {
    var data = jsonEncode(
        {"Username": currentUser?.displayName, "Password": currentUser?.email});
    var headers = {"Content-Type": "application/json"};
    final response = await http.post(Uri.parse('${apiUrl}/Auth/signin-google'),
        headers: headers, body: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      //final json = jsonDecode(response.body);
      //Token(json.tokenString,json.expiryDate);
      return response.body;
    } else {
      debugPrint('response :' + response.body);
      return null;
    }
  }
}
