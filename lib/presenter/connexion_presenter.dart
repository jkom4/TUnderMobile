
import 'package:tunder/Model/utilisateur.dart';
import 'package:tunder/presenter/i_connexion_view.dart';

import '../repository/connexion_repository.dart';

class ConnexionPresenter{

  late IConnexionView _view;
  late ConnexionRepository _repository;

   ConnexionPresenter(this._view) {
        _repository = new ConnexionRepository();
  }
   googleConnect(){
    _repository.signInWithGoogle().then((value) => print("value:" +  value.toString()) );
  }


  Connect(String email, String password)
  {

     _repository.fetchLogin(email, password)
        .then((value) =>
            print(value)
    )
        .catchError((onError) {
          print("error");
    });
  }


}