import 'package:flutter/material.dart';
import 'package:tunder/model/cours.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/repository/demande_repository.dart';
import 'package:tunder/repository/i_demande_repository.dart';
import 'package:tunder/presenter/i_mes_demandes.dart';

import '../Model/userSession.dart';

class MesDemandesPresenter {
  ImesDemandes mesDemandeView;
  final userSession = UserSessionProvider.getInstance;
  late IdemandeRepository demandeRepository = HttpDemandeRepository();

  MesDemandesPresenter(this.mesDemandeView);

  Future<List<Demande>?> getMyWaitingDemande() async {
     return await demandeRepository.getMyWaitingDemande();
  }


  bool isUser(String username){
    if(userSession!.currentUser().nom == username ){
      return true;
    }
    return false;
  }

  void updateStatus(int id, bool bool) async {
    try{
      Demande demande =  bool? Demande(id, "accepted", "", "", "", Cours(" ",""), null) : Demande(id, "rejected", "", "", "", Cours(" ",""), null);
      print("Id presenter =" + id.toString());
      await  demandeRepository.UpdateStatus(demande);
      mesDemandeView.displayConfirmation("Envoyé avec succès !");
    }on Error catch (e) {
      mesDemandeView.displayError(e.toString());
    }
  }
}
