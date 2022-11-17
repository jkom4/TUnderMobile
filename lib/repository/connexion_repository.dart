import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tunder/repository/i_connexion_repository.dart';
import 'package:http/http.dart' as http;

class ConnexionRepository implements IConnexionRepository {
  //TODO remove and use env
  String baseUrl =
      Platform.isAndroid ? 'http://10.0.2.2:5244' : 'http://localhost:5244';

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

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future logout() async {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  Future fetchLogin(String email, String password) async {
    var data = jsonEncode({"username": email, "password": password});
    var headers = {"Content-Type": "application/json"};
    final response = await http.post(Uri.parse('${baseUrl}/api/Auth/token'),
        headers: headers, body: data);
    if (response.statusCode == 200) {
      //final json = jsonDecode(response.body);
      return response.body;
    } else {
      debugPrint('response : $response');
      return null;
    }
  }
}
