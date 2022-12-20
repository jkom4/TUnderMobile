import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:tunder/model/cours.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/model/environment.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/repository/i_cours_repository.dart';
import 'package:http/http.dart' as http;

import '../Model/userSession.dart';

class HttpCoursRepository implements IcoursRepository {
  static final String apiUrl = Environment.apiUrl;

  HttpCoursRepository();

  @override
  Future<List<Cours>> getCoursFromBloc({required String blocName}) async {
    Response response = await http.get(Uri.parse("$apiUrl/Cours/$blocName"));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Cours.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch cours ${response.statusCode}');
    }
  }

  @override
  Future<List<Utilisateur>> getTuteursForCours(
      {required String blocName, required String coursName}) async {
    var jwtString;
    // je recupere le token dans le secureStorage
    await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      jwtString = value;
    });
    var json = jsonDecode(jwtString!);
    var token = json['tokenString'];
    Response response = await http
        .get(Uri.parse("$apiUrl/Cours/$blocName/Bloc/$coursName"), headers: {
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    });

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Utilisateur.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch tutor ${response.statusCode}');
    }
  }

  @override
  Future<List<Cours>> getAllCours() async {
    Response response = await http.get(Uri.parse("$apiUrl/Cours"));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Cours.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch cours');
    }
  }
}
