import 'package:tunder/model/cours.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/repository/cours_repository.dart';
import 'package:tunder/repository/i_cours_repository.dart';
import 'package:tunder/presenter/i_demande_tutorat.dart';

class DemandePresenter {
  IdemandeTutorat tutoratView;
  late IcoursRepository coursRepository = HttpCoursRepository();

  DemandePresenter(this.tutoratView);
  Future<List<Cours>> getAllClasses(String blocName) {
    return coursRepository.getCoursFromBloc(blocName: blocName);
  }

  Future<List<Utilisateur>> getTutorForClasses(
      String blocName, String coursname) {
    return coursRepository.getTuteursForCours(
        blocName: blocName, coursName: coursname);
  }

  void confirmForm(String blocSelected, String? coursSelected,
      String? tutorSelected, String? comment) {
    if (coursSelected == null || tutorSelected == null) {
      tutoratView.displayError("Vous devez choisir un cours et un tuteur");
    } else {
      tutoratView.displayConfirmation("Votre demande a bien été envoyée");
    }
  }
}
