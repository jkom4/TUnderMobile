// ignore_for_file: unnecessary_this

import 'dart:ffi';

import 'package:tunder/model/cours.dart';
import 'package:tunder/model/rencontre.dart';
import 'package:tunder/model/utilisateur.dart';

class Demande {
  late int id;
  String? commentaire;
  late String etat;
  late DateTime dateDemande;
  late int gestionnaireId;
  late int demandeurId;
  late int coursID;
  int? rencontreId;

  Demande(DateTime date, int demandeurId, int gestionnaireId, int coursId) {
    setDate = date;
    this.setEtat = "waiting";
    this.setGestionnaire = gestionnaireId;
    this.setDemandeur = demandeurId;
    this.setCours = coursId;
  }

  Demande.fromJson(Map<String, dynamic> json) {
    setId = int.parse(json['id']);
    setCommentaire = json['commentaire'];
    setEtat = json['etat'];
    setDate = DateTime.parse(json['dateDemande']);
    setGestionnaire = int.parse(json['gestionnaireId']);
    setDemandeur = int.parse(json['demandeurId']);
    setCours = int.parse(json['cours']);
    setRencontre = int.parse(json[rencontreId]);
  }

  int get getId {
    return this.id;
  }

  set setId(int id) {
    if (id > 0) {
      this.id = id;
    }
  }

  String? get getCommentaire {
    return this.commentaire;
  }

  set setCommentaire(String commentaire) {
    if (commentaire.isNotEmpty) {
      this.commentaire = commentaire;
    }
  }

  String? get getEtat {
    return this.etat;
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
    this.dateDemande = date;
  }

  DateTime get getDate {
    return this.dateDemande;
  }

  set setDemandeur(int demandeurId) {
    if (demandeurId > 0) {
      this.demandeurId = demandeurId;
    }
  }

  int? get getDemandeurId {
    return this.demandeurId;
  }

  set setGestionnaire(int gestionnaireId) {
    if (gestionnaireId > 0) {
      this.gestionnaireId = gestionnaireId;
    }
  }

  int? get getGestionnaireId {
    return this.getDemandeurId;
  }

  set setCours(int coursId) {
    if (coursId > 0) {
      this.coursID = coursId;
    }
  }

  int? get getCoursId {
    return this.coursID;
  }

  set setRencontre(int rencontreId) {
    if (rencontreId > 0) {
      this.rencontreId = rencontreId;
    }
  }

  int? get getRencontreId {
    return this.rencontreId;
  }
}
