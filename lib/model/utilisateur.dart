import 'package:json_annotation/json_annotation.dart';

part 'utilisateur.g.dart';

@JsonSerializable()
class Utilisateur {
  late String prenom;
  late String nom;
  late String email;

  Utilisateur(String prenom, String nom, String email) {
    setNom = nom;
    setPrenom = prenom;
    setEmail = email;
  }

  factory Utilisateur.fromJson(Map<String, dynamic> json) =>
      _$UtilisateurFromJson(json);

  Map<String, dynamic> toJson() => _$UtilisateurToJson(this);

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
