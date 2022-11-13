import 'package:flutter/material.dart';
import 'package:tunder/model/cours.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/repository/demande_repository.dart';
import 'package:tunder/repository/i_demande_repository.dart';
import 'package:tunder/view/i_mes_demandes.dart';

class MesDemandesPresenter {
  ImesDemandes mesDemandeView;
  late IdemandeRepository demandeRepository = HttpDemandeRepository();

  MesDemandesPresenter(this.mesDemandeView);

  Future<List<Demande>> getMyWaitingDemande() {
    //return demandeRepository.getMyWaitingDemande();
    List<Demande> demandes = List.empty(growable: true);
    demandes.add(Demande(
        DateTime.now(),
        "waiting",
        Utilisateur("Andrew", "Tistaert", "a.tistaert@evs.com"),
        Utilisateur("caca", "prout", "c.proute@evs.com"),
        Cours("Mathematique", "B1"),
        null));
    demandes.add(Demande(
        DateTime.now(),
        "waiting",
        Utilisateur("Khalil", "Kari", "K.Karim@odoo.com"),
        Utilisateur("caca", "prout", "c.proute@evs.com"),
        Cours("Arabe", "B4"),
        null));
    demandes.add(Demande(
        DateTime.now(),
        "waiting",
        Utilisateur("Antoine", "Bichon", "a.Bichon@evs.com"),
        Utilisateur("caca", "prout", "c.proute@evs.com"),
        Cours("Verdure", "B3"),
        null));
    debugPrint(demandes.first.getDemandeur!.getNom);
    return Future<List<Demande>>.delayed(
        const Duration(seconds: 1), () => demandes);
  }
}
