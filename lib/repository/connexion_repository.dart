import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tunder/repository/i_connexion_repository.dart';
import 'package:http/http.dart' as http;
class ConnexionRepository implements IConnexionRepository{
//  final String baseUrl = "https://127.0.0.1:5244";

  String baseUrl = Platform.isAndroid ? 'http://10.0.2.2:5244' : 'http://localhost:5244';
  @override
  Future fetchGoogleSign() async{
    final response = await http.get(Uri.parse('$baseUrl/api/signin-google'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }


  @override
  Future fetchLogin(String email, String password) async{
    var data = jsonEncode({"username": email,"password":password});
    var headers = {"Content-Type": "application/json"};
    final response = await http.post(Uri.parse('${baseUrl}/api/Auth/token'),headers : headers, body: data);
    if (response.statusCode == 200) {
      //final json = jsonDecode(response.body);
      return response.body;
    } else {
      debugPrint('response : $response');
      return null;
    }

  }}