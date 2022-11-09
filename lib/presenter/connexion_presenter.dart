import 'package:injector/injector.dart';
import 'package:flutter/foundation.dart';
import 'package:tunder/presenter/i_connexion_view.dart';

import '../repository/connexion_repository.dart';
import '../view/MyHomePage.dart';
import 'dart:developer';

class ConnexionPresenter{

  late IConnexionView _view;
  late ConnexionRepository _repository;
   ConnexionPresenter(this._view) {
        _repository = new ConnexionRepository();
  }
   googleConnect(){
     _repository.fetchGoogleSign();
  }
  Connect(String email, String password)
  {
    var response = _repository.fetchLogin(email, password)
        .then((value) => {
      print(value),
      _view.ShowMessage(value)
    })
        .catchError((onError) {
          print("error");
    });
  }
}