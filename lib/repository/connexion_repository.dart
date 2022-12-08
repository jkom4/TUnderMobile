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
    final response = await http.post(Uri.parse('${apiUrl}/Auth/token'),
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
    final response = await http.post(Uri.parse('${apiUrl}/Auth/signin-google'),
        headers: headers, body: data);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint('response for jwtOauth :${response.body}');
      return null;
    }
  }

  @override
  Future fetchUsrHoraire() async {
    return await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.get(Uri.parse("$apiUrl/Horaire"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token"
          });
      if (response.statusCode != 200) {
        String mess = response.statusCode.toString();
        throw Exception('Failed to get get horaire: {$mess}');
      }
      return response.body;
    });
  }

  @override
  Future getUsrLink() async {
    return await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.get(Uri.parse("$apiUrl/Horaire/link"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token"
          });
      if (response.statusCode != 200) {
        String mess = response.statusCode.toString();
        throw Exception('Failed to get get horaire link: {$mess}');
      }
      return response.body;
    });
  }

  @override
  Future postUsrLink(String link) async {
    return await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.put(
          Uri.parse("$apiUrl/Horaire?link=$link"),
          headers: {"Authorization": "bearer $token"});
      if (response.statusCode != 200) {
        String mess = response.statusCode.toString();
        throw Exception('Failed to post horaire link: {$mess}');
      }
      return response.body;
    });
  }

  @override
  Future<List> fetchRendezVous() async {
    return await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.get(Uri.parse("$apiUrl/Tutorat/RendezVousUser"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token"
          });
      if (response.statusCode != 200) {
        String mess = response.statusCode.toString();
        throw Exception('Failed to get rdv for user: {$mess}');
      }
      return jsonDecode(response.body) as List;
    });
  }
}
