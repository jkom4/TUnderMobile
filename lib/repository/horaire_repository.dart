import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:tunder/repository/i_horraire_repository.dart';
import '../Model/environment.dart';
import '../Model/userSession.dart';

class HoraireRepository implements IHoraireRepository {
  static final String apiUrl = Environment.apiUrl;

  HoraireRepository();
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
      if (response.statusCode != 200 && response.statusCode != 404) {
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
      Response response = await http.get(Uri.parse("$apiUrl/Horaire/Link"),
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
      Response response = await http.put(Uri.parse("$apiUrl/Horaire/$link"),
          headers: {"Authorization": "bearer $token"});
      if (response.statusCode != 200) {
        String mess = response.statusCode.toString();
        throw Exception('Failed to post horaire link: {$mess}');
      }
      return response.body;
    });
  }
}
