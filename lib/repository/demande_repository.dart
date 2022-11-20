import 'dart:convert';
import 'package:http/http.dart';
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
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiVHVuZGVyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoidHVuZGVyQHR1bmRlci5jb20iLCJSb2xlcyI6ImF1dGgud2VhdGhlciIsImV4cCI6MTY2ODk0Nzg0MywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjQ0LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI0NC8ifQ.Wxus6gr9M310-psorRbKYeIheLEeqEUc8wKR6BqRfEk";

    Response response = await http.get(Uri.parse("$apiUrl/Tutorat"), headers: {
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    });

    if (response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);

      List<Demande> demandes = (json.decode(response.body) as List)
          .map((i) => Demande.fromJson(i))
          .toList();

      return demandes;
    } else {
      throw Exception('Failed to fetch cours');
    }
  }

  @override
  Future addDemande(Demande mydemande) async {
    //String token = UserSession.instance!.getUserSession;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiVHVuZGVyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoidHVuZGVyQHR1bmRlci5jb20iLCJSb2xlcyI6ImF1dGgud2VhdGhlciIsImV4cCI6MTY2ODk0Nzg0MywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjQ0LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI0NC8ifQ.Wxus6gr9M310-psorRbKYeIheLEeqEUc8wKR6BqRfEk";

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
