import 'dart:convert';
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
  Future<List<Demande>> handleDemand() {
    // TODO: implement handleDemand
    throw UnimplementedError();
  }

  @override
  Future<List<Demande>> getMyWaitingDemande() async {

    await UserSessionProvider.getInstance!.get(key: "jwtToken").then((value) async {

      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.get(Uri.parse("$apiUrl/Tutorat"), headers: {
        "Content-Type": "application/json",
        "Authorization": "bearer $token"
      });
      print("200 token" + token.toString());
      if (response.statusCode == 200) {
        Iterable r = jsonDecode(response.body);

        List<Demande> demandes = await (json.decode(response.body) as List)
            .map((i) => Demande.fromJson(i))
            .toList();
        return demandes;
      } else {
        String mess = response.statusCode.toString();
        throw Exception('Failed to fetch waiting demande {$mess}');
      }
    });
    return List.empty();

  }

  @override
  Future addDemande(Demande mydemande) async {
    // je recupere le token dans le secureStorage
    await UserSessionProvider.getInstance!.get(key: "jwtToken").then((value)  async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.post(Uri.parse("$apiUrl/Tutorat"),
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
}
