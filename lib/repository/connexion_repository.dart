import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:tunder/model/rencontre.dart';
import 'package:tunder/repository/i_connexion_repository.dart';
import 'package:http/http.dart' as http;

import '../Model/environment.dart';
import '../Model/userSession.dart';

class ConnexionRepository implements IConnexionRepository {
  static final String apiUrl = Environment.apiUrl;
  late String jwtToken;
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
    //Creation du token JWT
    FirebaseAuth.instance.signInWithCredential(credential);
    //await fecthJwtForSigninGoogle(googleUser).then((value) => jwtToken = value);

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(credential);
    return await fecthJwtForSigninGoogle(googleUser);
  }

  Future logout() async {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  Future fetchLogin(String username, String password) async {
    var data =
        jsonEncode({"username": username, "email": "", "password": password});
    var headers = {"Content-Type": "application/json"};
    final response = await http.post(Uri.parse('${apiUrl}/Users/SignIn'),
        headers: headers, body: data);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  @override
  Future fecthJwtForSigninGoogle(GoogleSignInAccount? user) async {
    var data =
        jsonEncode({"Username": user?.displayName, "Email": user?.email});
    //{"Username": "Tunder", "Password": "tunder@tunder.com"});
    var headers = {"Content-Type": "application/json"};
    final response = await http.post(Uri.parse('${apiUrl}/Users/SignIn-google'),
        headers: headers, body: data);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint('response for jwtOauth :${response.body}');
      return null;
    }
  }
}
