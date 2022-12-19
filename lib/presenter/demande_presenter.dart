import 'package:tunder/model/cours.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/model/rencontre.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/repository/cours_repository.dart';
import 'package:tunder/repository/demande_repository.dart';
import 'package:tunder/repository/i_cours_repository.dart';
import 'package:tunder/presenter/i_demande_tutorat.dart';
import 'package:tunder/repository/i_demande_repository.dart';

///Cette classe permet de gerer les demandes
class DemandePresenter {
  IdemandeTutorat tutoratView;
  late IcoursRepository coursRepository = HttpCoursRepository();
  late IdemandeRepository demandeRepository = HttpDemandeRepository();

  DemandePresenter(this.tutoratView);

  /// Recupère les tous les cours d'un bloc donné
  /// params String blocName
  /// Return List
  Future<List<Cours>> getAllClasses(String blocName) {
    return coursRepository.getCoursFromBloc(blocName: blocName);
  }
  /// Recupère les tuteurs d'un bloc donné et d'un cours donné
  /// params String blocName, String coursname
  /// Return List
  Future<List<Utilisateur>> getTutorForClasses(
      String blocName, String coursname) {
    return coursRepository.getTuteursForCours(
        blocName: blocName, coursName: coursname);
  }

  ///Permet d'ajouter une nouvelle demande de tutorat
  void confirmForm(String blocSelected, String? coursSelected,
      String? tutorSelected, String? comment, String? date, String? lieu) {
    try {
      Cours cours = Cours(coursSelected, blocSelected);
      Rencontre rencontre = Rencontre(date, lieu);
      Demande demandeToAdd =
          Demande(0,"waiting", comment, "", tutorSelected, cours, rencontre);
      demandeRepository.addDemande(demandeToAdd).onError(
          (error, stackTrace) => tutoratView.displayError(error.toString()));
      tutoratView.displayConfirmation("Votre demande a bien été envoyée");
      tutoratView.refresh();
    }catch (e) {
      tutoratView.displayError(e.toString());
    }
  }
}
