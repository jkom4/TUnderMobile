import 'package:tunder/model/role.dart';
import 'package:tunder/model/synthese.dart';
import 'package:tunder/model/cours.dart';

class Utilisateur {
  late int id;
  String prenom;
  String nom;
  String email;
  Utilisateur(this.prenom, this.nom, this.email);
}
