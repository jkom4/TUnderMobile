import 'package:tunder/presenter/i_connexion.dart';

import '../model/token.dart';
import '../repository/connexion_repository.dart';
import '../repository/i_connexion_repository.dart';

class ConnexionPresenter {
  late IConnexionView _view;
  late IConnexionRepository _repository;
  late UserSession userSession;

  ConnexionPresenter(this._view) {
    _repository = ConnexionRepository();
  }
  googleConnect() {
    _repository
        .signInWithGoogle()
        .then((value) => {
              print("Value: " + value.toString()),
            })
        .catchError(
            (onError) => _view.showMessage("Erreur :" + onError.toString()));
  }

  logout() {
    _repository.logout();
  }

  Connect(String email, String password) {
    _repository
        .fetchLogin(email, password)
        .then((value) => {
              print(value),
              UserSession.instance?.setUserSession(value.toString())
            })
        .catchError((onError) {
      print("error : " + onError.toString());
    });
  }
}
