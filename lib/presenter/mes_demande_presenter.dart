
import 'package:tunder/model/cours.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/repository/demande_repository.dart';
import 'package:tunder/repository/i_demande_repository.dart';
import 'package:tunder/presenter/i_mes_demandes.dart';

import '../Model/userSession.dart';


/// Cette classe permet de gerer les demandes de tutorat
class MesDemandesPresenter {
  ImesDemandes mesDemandeView;
  final userSession = UserSessionProvider.getInstance;
  late IdemandeRepository demandeRepository = HttpDemandeRepository();
  ///Constructeur doit prendre en parametre la vue
  MesDemandesPresenter(this.mesDemandeView);

  ///Permet de recuperer la liste de demande  pour l'utilisateur courant
  Future<List<Demande>?> getMyWaitingDemande() async {
     return await demandeRepository.getMyWaitingDemande();
  }

  ///Permet de verifier s'il s'agit du current user
  ///params String username(le username dont on veut tester)
  ///return true s'il est bien le current user et false sinon
  bool isUser(String username){
    if(userSession!.currentUser().nom == username ){
      return true;
    }
    return false;
  }

  ///Permet de modifeir le status d'une demande
  ///params int id( id de la demande), bool bool (true pour accepter la demande et false pour refuser)
  void updateStatus(int id, bool bool) async {
    try{
      Demande demande =  bool? Demande(id, "accepted", "", "", "", Cours(" ",""), null) : Demande(id, "rejected", "", "", "", Cours(" ",""), null);
      await  demandeRepository.UpdateStatus(demande);
      mesDemandeView.displayConfirmation("Envoyé avec succès !");
    }on Error catch (e) {
      mesDemandeView.displayError(e.toString());
    }
  }
}
