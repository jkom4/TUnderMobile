import 'package:json_annotation/json_annotation.dart';

part 'utilisateur.g.dart';

@JsonSerializable()
class Utilisateur {
  late String prenom;
  late String nom;
  late String email;
  late String role;

  Utilisateur(String prenom, String nom, String email,String role) {
    setNom = nom;
    setPrenom = prenom;
    setEmail = email;
    setRole = role;
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
  String get geRole {
    return role;
  }

  set setRole(String role) {
    if (role.isNotEmpty) {
      this.role = role;
    }
  }
}
