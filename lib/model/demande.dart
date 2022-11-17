import 'package:tunder/model/cours.dart';
import 'package:tunder/model/rencontre.dart';
import 'package:tunder/model/utilisateur.dart';

class Demande {
  String? commentaire;
  late String etat;
  late DateTime dateDemande;
  late String? gestionnaire;
  late String? demandeur;
  late Cours cours;
  Rencontre? rencontre;

  Demande(DateTime date, String etat, String? demandeur, String? gestionnaire,
      Cours cours, Rencontre? recontre) {
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
    setGestionnaire = json['gestionnaire'];
    setDemandeur = json['demandeur'];
    setCours = Cours.fromJson(json['cours']);
    setRencontre = Rencontre.fromJson(json[rencontre]);
  }
  Map<String, dynamic> toJson() => {
        'commentaire': commentaire,
        'etat': etat,
        'dateDemande': dateDemande,
        'gestionnaire': gestionnaire,
        'demandeur': demandeur,
        'cours': {
          'bloc': cours.bloc,
          'nom': cours.nom,
        },
        'rencontre': {'date': rencontre?.date, 'addresse': rencontre?.addresse}
      };

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

  set setDemandeur(String? demandeur) {
    this.demandeur = demandeur;
  }

  String? get getDemandeur {
    return demandeur;
  }

  set setGestionnaire(String? gestionnaire) {
    this.gestionnaire = gestionnaire;
  }

  String? get getGestionnaire {
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
