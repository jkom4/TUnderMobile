import 'package:tunder/model/demande.dart';

class Rencontre {
  int id;
  DateTime date;
  String addresse;
  Demande demande;

  Rencontre(this.id, this.date, this.addresse, this.demande);
}
