import 'package:tunder/model/cours.dart';

abstract class IcoursRepository {
  Future<List<Cours>> getCours();
}
