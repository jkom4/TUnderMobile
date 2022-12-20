
import 'package:file_picker/src/file_picker_result.dart';
import 'package:tunder/model/synthese.dart';
import 'package:tunder/presenter/i_synthese.dart';
import 'package:tunder/repository/synthese_repository.dart';

import '../model/cours.dart';
import '../repository/cours_repository.dart';
import '../repository/i_cours_repository.dart';
import '../repository/i_synthese_repository.dart';

/// Cette classe permet de gerer les syntheses
class SynthesePresenter {
  ISyntheseView _view;
  late IcoursRepository coursRepository = HttpCoursRepository();
  late ISyntheseRepository _repository = SyntheseRepository();
  late List<Synthese> syntheses = [];

  SynthesePresenter(this._view);

  /// Recupère les tous les cours d'un bloc données
  /// params String blocName
  /// Return List
  Future<List<Cours>> getAllClasses(String blocName) {
    return coursRepository.getCoursFromBloc(blocName: blocName);
  }

  /// Recupère tous les cours de la base de données
  /// Returns List
  Future<List<Cours>> getAllCours() {
    return coursRepository.getAllCours();
  }

  /// Permet d'ajouter une synthèse
  /// le fichier est dabord upload sur firebase et puis les données sont enregistrées dans la base de donneés
  /// params String blocSelected (Le bloc), String cours(nom du cours), FilePickerResult result(le fichier selectionné)
  void addSynthese(String blocSelected, String? coursSelected,
      FilePickerResult? result) async {
    if (coursSelected == null && result == null) {
      _view.displayError("Veuillez selectionner le cours et une synthese");
    } else {
      Cours cours = Cours(coursSelected, blocSelected);
      await _repository.saveFile(result!).then((url) async {
        Synthese synthese = Synthese(0, null, url, null, cours);
        await _repository.addSynthese(synthese);
        _view.displayConfirmation("Synthèse enregistrée");
      }).catchError((e) {
        _view.displayError("Impossible de charger le fichier");
      });
    }
  }
  ///Permet de recuperer toutes les syntheses
  /// return Future List
  Future getSyntheses() async {
    await _repository
        .getSynthese()
        .then((value) => syntheses = value ?? []);

  }
  ///Permet de recuperer les synthèses par rapport a un cours donné
  ///params Cours cours (le cours dont on veut recuperer les synthèses)
  ///return Future<List>
  Future<List<Synthese>> synthesesForCours(Cours cours) async {
    await getSyntheses();
    List<Synthese> synthesesForCours = [];
    for (var value in syntheses) {
      if (value.cours.getNom == cours.getNom &&
          value.cours.getBloc == cours.getBloc) {
        synthesesForCours.add(value);
      }
    }

    return synthesesForCours;
  }
  ///Permet de telecharger le fichier grace a son url
  /// params String url (url du fichier)
  /// return Future
  Future downloadFile(String url) async {
    return await _repository.downloadFile(url);
  }
}
