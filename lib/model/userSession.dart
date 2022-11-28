

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:tunder/model/utilisateur.dart';


class UserSessionProvider {

  static final UserSessionProvider? _instance = UserSessionProvider._internal();
  late  FlutterSecureStorage _flutterSecureStorage;
  late String jwtToken ;

  UserSessionProvider._internal() {
    this._flutterSecureStorage =  FlutterSecureStorage();
  }
  static UserSessionProvider? get getInstance => _instance;

  Future<void> set({required String key, required String value}) async {
    await _flutterSecureStorage.write(key: key, value: value);
    jwtToken = value;
  }

  Future<String?> get({required String key}) async {
    return Future.delayed(Duration(seconds: 2),()
    {
      return _flutterSecureStorage.read(key: key);
    });

  }
  Future<void> clear() async {
    await _flutterSecureStorage.delete(key: "jwtToken");
  }


  Utilisateur currentUser() {
    var json = jsonDecode(jwtToken);
    var token = json['tokenString'];
    // To decode the token
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    // Print the payload
    print( "payload "+ payload.toString());
    return new Utilisateur(payload['Name'], payload['Name'], payload['Email']);
  }

}