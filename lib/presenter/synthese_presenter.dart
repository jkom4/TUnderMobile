import 'package:tunder/presenter/i_synthese.dart';

import '../model/cours.dart';
import '../repository/cours_repository.dart';
import '../repository/i_cours_repository.dart';

class SynthesePresenter{
  ISyntheseView _view;
  late IcoursRepository coursRepository = HttpCoursRepository();

  SynthesePresenter(this._view);

  Future<List<Cours>> getAllClasses(String blocName) {
    return coursRepository.getCoursFromBloc(blocName: blocName);
  }
}