import 'package:tunder/model/userSession.dart';
import 'package:tunder/presenter/i_message.dart';
import 'package:tunder/repository/cours_repository.dart';
import 'package:tunder/repository/i_cours_repository.dart';

import '../model/cours.dart';

///Cette classe permet de gerer le chat
class MessagePresenter {
  late IMessagesView _view;
  late IcoursRepository _repository;

  MessagePresenter(this._view) {
    _repository = HttpCoursRepository();
  }
  /// Recupère tous les cours de la base de données
  /// Returns List
  Future<List<Cours>> getAllCours() {
    return _repository.getAllCours();
  }

  ///Permet de recuperer l'adresse mail du current User
  ///return String
  String getUsrMail() {
    if (UserSessionProvider.getInstance != null) {
      return UserSessionProvider.getInstance!.currentUser().email;
    } else {
      _view.displayError("UserSession Invalide");
      return "";
    }
  }
}
