import 'package:tunder/model/cours.dart';
import 'package:tunder/model/rencontre.dart';
import 'package:tunder/model/utilisateur.dart';

class Demande {
  late int? Id;
  String? commentaire;
  late String etat;
  late DateTime dateDemande;
  late Utilisateur? gestionnaire;
  late Utilisateur? demandeur;
  late Cours cours;
  Rencontre? rencontre;

  Demande(int? id, DateTime date, String etat, Utilisateur? demandeur,
      Utilisateur? gestionnaire, Cours cours, Rencontre? recontre) {
    setId = id;
    setDate = date;
    setEtat = etat;
    setGestionnaire = gestionnaire;
    setDemandeur = demandeur;
    setCours = cours;
    rencontre = rencontre;
  }

  Demande.fromJson(Map<String, dynamic> json) {
    setCommentaire = json['commentaire'];
    setEtat = json['etat'];
    setDate = DateTime.parse(json['dateDemande']);
    setGestionnaire = Utilisateur.fromJson(json['gestionnaire']);
    setDemandeur = Utilisateur.fromJson(json['gestionnaire']);
    setCours = Cours.fromJson(json['cours']);
    setRencontre = Rencontre.fromJson(json[rencontre]);
  }

  set setId(int? id) {
    Id = id;
  }

  int? get getId {
    return Id;
  }

  String? get getCommentaire {
    return commentaire;
  }

  set setCommentaire(String commentaire) {
    if (commentaire.isNotEmpty) {
      this.commentaire = commentaire;
    }
  }

  String? get getEtat {
    return etat;
  }

  set setEtat(String etat) {
    if (etat.isNotEmpty) {
      etat = etat.toLowerCase();
      if (etat == "waiting" || etat == "accepted" || etat == "rejected") {
        this.etat = etat;
      }
    }
  }

  set setDate(DateTime date) {
    dateDemande = date;
  }

  DateTime get getDate {
    return dateDemande;
  }

  set setDemandeur(Utilisateur? demandeur) {
    this.demandeur = demandeur;
  }

  Utilisateur? get getDemandeur {
    return demandeur;
  }

  set setGestionnaire(Utilisateur? gestionnaire) {
    this.gestionnaire = gestionnaire;
  }

  Utilisateur? get getGestionnaire {
    return gestionnaire;
  }

  set setCours(Cours cours) {
    this.cours = cours;
  }

  Cours get getCours {
    return cours;
  }

  set setRencontre(Rencontre rencontre) {
    this.rencontre = rencontre;
  }

  Rencontre? get getRencontre {
    return rencontre;
  }
}
