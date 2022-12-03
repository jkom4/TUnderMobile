import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/presenter/i_connexion.dart';
import '../model/userSession.dart';
import '../repository/connexion_repository.dart';
import '../repository/i_connexion_repository.dart';

class ConnexionPresenter {
  late IConnexionView _view;
  late IConnexionRepository _repository;
  final userSession = UserSessionProvider.getInstance;
  late String jwtToken;

  ConnexionPresenter(this._view) {
    _repository = ConnexionRepository();
  }

  googleConnect() {
    _repository
        .signInWithGoogle()
        .then((value) =>
            {userSession?.set(key: "jwtToken", value: value), _view.refresh()})
        .catchError((onError) =>
            _view.showMessage("Erreur Oauth:" + onError.toString()));
  }

  logout() {
    _repository.logout();
    userSession?.clear();
    _view.refresh();
  }

  Connect(String email, String password) {
    _repository
        .fetchLogin(email, password)
        .then((value) => {
              print(value),
              userSession?.set(key: "jwtToken", value: value),
              _view.refresh(),
            })
        .catchError((onError) {
      print("error login : " + onError.toString());
      _view.showMessage("Error login : " + onError.toString());
    });
  }

  Utilisateur currentUser() {
    //print(userSession?.currentUser().toJson());
    return userSession!.currentUser();
  }

  Future getHoraireLink() {
    return _repository.getUsrLink();
  }

  void updateLink(String link) {
    if (link.isEmpty) {
      _view.showMessage("Erreur : Lien vide ou nul");
    } else {
      var parsedUri = Uri.encodeComponent(link);
      _repository
          .postUsrLink(parsedUri)
          .then((value) => _view.showMessage('Lien mis à jour!'))
          .onError((error, stackTrace) => _view.showMessage(error.toString()));
    }
  }
}
