import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tunder/model/cours.dart';
import 'package:tunder/model/rencontre.dart';

part 'demande.g.dart';

@JsonSerializable(explicitToJson: true)
class Demande {
  String? commentaire;
  late String etat;
  late String gestionnaire;
  late String demandeur;
  late Cours cours;
  late Rencontre rencontre;

  Demande(String etat, String? commentaire, String? demandeur,
      String? gestionnaire, Cours cours, Rencontre? rencontre) {
    setEtat = etat;
    setGestionnaire = gestionnaire;
    setDemandeur = demandeur;
    setCours = cours;
    setRencontre = rencontre;
    setCommentaire = commentaire;
  }

  factory Demande.fromJson(Map<String, dynamic> json) =>
      _$DemandeFromJson(json);

  Map<String, dynamic> toJson() => _$DemandeToJson(this);

  String? get getCommentaire {
    return commentaire;
  }

  set setCommentaire(String? commentaire) {
    if (commentaire != null) {
      this.commentaire = commentaire;
    } else {
      this.commentaire = "";
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

  set setDemandeur(String? demandeur) {
    if (demandeur != null) {
      this.demandeur = demandeur;
    } else {
      throw Exception('Demandeur non selectionné');
    }
  }

  String? get getDemandeur {
    return demandeur;
  }

  set setGestionnaire(String? gestionnaire) {
    if (gestionnaire != null) {
      this.gestionnaire = gestionnaire;
    } else {
        throw Exception('Gestionnaire non selectionné');
    }
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

  set setRencontre(Rencontre? rencontre) {
    if (rencontre == null) {
      debugPrint("ici");
      this.rencontre = Rencontre(null, "");
    } else {
      this.rencontre = rencontre;
    }
  }

  Rencontre get getRencontre {
    return rencontre;
  }
}
