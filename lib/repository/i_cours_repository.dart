import 'package:tunder/model/cours.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/model/utilisateur.dart';

abstract class IcoursRepository {
  Future<List<Cours>> getCoursFromBloc({required String blocName});
  Future<List<Utilisateur>> getTuteursForCours(
      {required String blocName, required String coursName});
}
