import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/presenter/i_connexion.dart';
import '../model/userSession.dart';
import '../repository/connexion_repository.dart';
import '../repository/i_connexion_repository.dart';

///Cette classe permet de gerer la connexion d'un utilisateur
class ConnexionPresenter {
  late IConnexionView _view;
  late IConnexionRepository _repository;
  final userSession = UserSessionProvider.getInstance;
  late String jwtToken;

  ConnexionPresenter(this._view) {
    _repository = ConnexionRepository();
  }

  ///Permet de connecter un utilisateur avec son compte google
  ///Une fois que les credentials sont bon et le JWT obtenu alors on le set dans le FlutterSecureStorage
  googleConnect() {
    _repository
        .signInWithGoogle()
        .then((value) {

      userSession?.set(key: "jwtToken", value: value);
      _view.refresh();
    })
        .catchError((onError) {
      _view.showMessage("Nom d'utilisateur ou mot de passe incorrect! ");
    });
  }

  ///Permet de deconnecter un utilisateur connecté
  logout() {
    _repository.logout();
    userSession?.clear();
    _view.refresh();
  }

  ///Permet de connecter un utilisateur de façon standard avec un login et mot de passe
  ///Une fois que les credentials sont bon et le JWT obtenu alors on le set dans le FlutterSecureStorage
  Connect(String email, String password) {
    if(email.isNotEmpty && password.isNotEmpty){

      _repository
          .fetchLogin(email, password)
          .then((value)
      {
        userSession?.set(key: "jwtToken", value: value);
        _view.refresh();
      })
          .catchError((onError) {
        _view.showMessage("Nom d'utilisateur ou mot de passe incorrect! ");
      });
    }
    else
      {
        _view.showMessage("Nom d'utilisateur ou mot de passe incorrect! ");
      }

  }
  ///Permet de recuperer les données de l'utilisateur connecté
  ///return objet Json {nom : "", email : ""}
  String currentUser() {
    final user = userSession!.currentUser();
    return jsonEncode({"nom" : user.getNom,"email" : user.getEmail}) ;
  }

  ///Permet de recuperer l'horaire de l'utilisateur connecté
  ///return Future avec l'url
  Future getHoraireLink() {
    return _repository.getUsrLink();
  }

  ///Permet de mettre a jour le lien d'horaire
  void updateLink(String link) {
    if (link.isEmpty) {
      _view.showMessage("Erreur : Lien vide ou null");
    } else {
      var parsedUri = Uri.encodeComponent(link);
      _repository
          .postUsrLink(parsedUri)
          .then((value) => _view.showMessage('Lien mis à jour!'))
          .onError((error, stackTrace) => _view.showMessage(error.toString()));
    }
  }
}
