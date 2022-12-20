
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

  ///Permet de modifier le statut d'une demande
  ///params int id( id de la demande), bool bool (true pour accepter la demande et false pour refuser)
  void updateStatus(int id, int statut) async {

    try{
      Demande demande =  statut == 1 ? Demande(id, "accepted", "", "", "", Cours(" ",""), null) : statut == 0?  Demande(id, "rejected", "", "", "", Cours(" ",""), null)
      :Demande(id, "canceled", "", "", "", Cours(" ",""), null) ;
      await  demandeRepository.UpdateStatus(demande);
      mesDemandeView.displayConfirmation("Envoyé avec succès !");
      mesDemandeView.refresh();
    }on Error catch (e) {
      mesDemandeView.displayError(e.toString());
    }
  }
  ///Permet de trier les demandes par date
  ///params data la liste de demandes a trier, id (la variable correspondant a la l'ordre de trie 1 ou -1)
  /// retourne un entier correspondant a l'ordre de trie. si il est demande de trier en croissant(1) alors il retourne -1
  sort( data,int id) {
    data = data as List<Demande>;
    if(id == 1){
      data.sort((a,b) {
        return a.rencontre.getDate.compareTo(b.rencontre.getDate);
      });
      return -1;
    }else{
      data.sort((a,b) {
        return b.rencontre.getDate.compareTo(a.rencontre.getDate);
      });
      return 1;
    }


  }

  ///Permet de trier les demandes par statut
  ///params data la liste de demandes a trier, id (la variable correspondant a la l'ordre de trie 1 ou -1)
  /// retourne un entier correspondant a l'ordre de trie. si il est demande de trier en croissant(1) alors il retourne -1
   sortByStatut(data,int id) {
     data = data as List<Demande>;
     if (id == 1) {
       data.sort((a, b) {
         return a.getEtat!.compareTo(b.getEtat!);
       });
       return -1;
     } else {
       data.sort((a, b) {
         return b.getEtat!.compareTo(a.getEtat!);
       });
       return 1;
     }
   }
}
