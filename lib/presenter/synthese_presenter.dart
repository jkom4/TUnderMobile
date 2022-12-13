import 'dart:io';

import 'package:file_picker/src/file_picker_result.dart';
import 'package:tunder/model/synthese.dart';
import 'package:tunder/presenter/i_synthese.dart';
import 'package:tunder/repository/synthese_repository.dart';

import '../model/cours.dart';
import '../repository/cours_repository.dart';
import '../repository/i_cours_repository.dart';
import '../repository/i_synthese_repository.dart';

class SynthesePresenter {
  ISyntheseView _view;
  late IcoursRepository coursRepository = HttpCoursRepository();
  late ISyntheseRepository _repository = SyntheseRepository();
  late List<Synthese> syntheses = [];

  SynthesePresenter(this._view);

  Future<List<Cours>> getAllClasses(String blocName) {
    return coursRepository.getCoursFromBloc(blocName: blocName);
  }

  Future<List<Cours>> getAllCours() {
    return coursRepository.getAllCours();
  }

  void addSynthese(String blocSelected, String? coursSelected,
      FilePickerResult? result) async {
    if (coursSelected == null && result == null) {
      _view.displayError("Veuillez selectionner le cours et une synthese");
    } else {
      Cours cours = Cours(coursSelected, blocSelected);
      await _repository.saveFile(result!).then((value) async {
        print("file save !");
        Synthese synthese =
            Synthese(0, null, result.files.first.name, null, cours);
        await _repository.addSynthese(synthese);
        _view.displayConfirmation("Synthèse enregistrée");
      }).catchError((e) {
        _view.displayError("Impossible de charger le fichier");
      });
    }
  }

  Future getSyntheses() async {
    await _repository
        .getSynthese()
        .then((value) => syntheses = value ?? [])
        .catchError(
            (onError) => print("error synthese : " + onError.toString()));
  }

  Future<List<Synthese>> synthesesForCours(Cours cours) async {
    await getSyntheses();
    List<Synthese> synthesesForCours = [];
    for (var value in syntheses) {
      if (value.cours.getNom == cours.getNom && value.cours.getBloc == cours.getBloc) {

        synthesesForCours.add(value);
      }
    }

    return synthesesForCours;
  }

   Future downloadFile(String fileName) async {
   return await _repository.downloadFile(fileName);

  }
}
