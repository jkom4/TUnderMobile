import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:tunder/Model/userSession.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/model/environment.dart';
import 'package:tunder/repository/i_demande_repository.dart';
import 'package:http/http.dart' as http;

class HttpDemandeRepository implements IdemandeRepository {
  static final apiUrl = Environment.apiUrl;

  HttpDemandeRepository();

  @override
  Future<List<Demande>?> getMyWaitingDemande() async {
    var jwt;
    await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      jwt = value;
    });

    var json = jsonDecode(jwt!);
    var token = json['tokenString'];
    Response response = await http.get(Uri.parse("$apiUrl/Tutorats"), headers: {
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    });

    if (response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);

      List<Demande> demandes = await (jsonDecode(response.body) as List)
          .map((i) => Demande.fromJson(i))
          .toList();
      return demandes;
    } else {
      String mess = response.statusCode.toString();
      throw Exception('Failed to fetch waiting demande {$mess}');
    }
  }

  @override
  Future addDemande(Demande mydemande) async {
    // je recupere le token dans le secureStorage
    await UserSessionProvider.getInstance!.get(key: "jwtToken").then((value)  async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.post(Uri.parse("$apiUrl/Tutorats/Tutorat"),
          body: jsonEncode(mydemande.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token"
          });
      if (response.statusCode != 200) {
        String mess = response.statusCode.toString();
        throw Exception('Failed to add demande {$mess}');
      }
    });
  }

  @override
  Future updateStatus(Demande demandeToUpdate) async {
    // je recupere le token dans le secureStorage
    await UserSessionProvider.getInstance!.get(key: "jwtToken").then((value)  async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];

      Response response = await http.put(Uri.parse("$apiUrl/Tutorats/Tutorat/Status"),
          body: jsonEncode(demandeToUpdate.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token"
          });
      if (response.statusCode != 200) {
        String mess = response.statusCode.toString();
        debugPrint('Failed to update status {$mess}');
      }
    });
  }
  @override
  Future<List> fetchRendezVous() async {
    return await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http
          .get(Uri.parse("$apiUrl/Tutorats/Rencontres"), headers: {
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
