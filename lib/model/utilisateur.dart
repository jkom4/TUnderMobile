import 'package:tunder/model/role.dart';
import 'package:tunder/model/synthese.dart';
import 'package:tunder/model/cours.dart';

class Utilisateur {
  late String prenom;
  late String nom;
  late String email;

  Utilisateur(this.prenom, this.nom, this.email);

  Utilisateur.fromJson(Map<String, dynamic> json) {
    setNom = json['nom'];
    setPrenom = json['prenom'];
    setEmail = json['email'];
  }

  String get getNom {
    return nom;
  }

  set setNom(String nom) {
    if (nom.isNotEmpty) {
      this.nom = nom;
    }
  }

  String get getPrenom {
    return prenom;
  }

  set setPrenom(String prenom) {
    if (prenom.isNotEmpty) {
      this.prenom = prenom;
    }
  }

  String get getEmail {
    return email;
  }

  set setEmail(String email) {
    if (email.isNotEmpty) {
      this.email = email;
    }
  }
}
