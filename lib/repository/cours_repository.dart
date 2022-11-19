import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tunder/model/cours.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/model/environment.dart';
import 'package:tunder/model/token.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/repository/i_cours_repository.dart';
import 'package:http/http.dart' as http;

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
      throw Exception('Failed to fetch cours');
    }
  }

  @override
  Future<List<Utilisateur>> getTuteursForCours(
      {required String blocName, required String coursName}) async {
    Response response =
        await http.get(Uri.parse("$apiUrl/Cours/$blocName/bloc/$coursName"));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Utilisateur.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch tutor');
    }
  }

  @override
  Future addDemande(Demande mydemande) async {
    //String token = UserSession.instance!.getUserSession;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiVHVuZGVyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoidHVuZGVyQHR1bmRlci5jb20iLCJSb2xlcyI6ImF1dGgud2VhdGhlciIsImV4cCI6MTY2ODkxMTM3MywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjQ0LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI0NC8ifQ.80tjdtfwUoPpfNfdvwaVNm2OF2bT7csrCWFZ_k3HVbw";

    debugPrint(jsonEncode(mydemande.toJson()).toString());

    Response response = await http.post(Uri.parse("$apiUrl/Tutorat"),
        body: jsonEncode(mydemande.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $token"
        });
    if (response.statusCode != 200) {
      throw Exception('Failed to add demande');
    }
  }
}
