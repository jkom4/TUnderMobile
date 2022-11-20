import 'package:tunder/model/demande.dart';
import 'package:tunder/repository/demande_repository.dart';
import 'package:tunder/repository/i_demande_repository.dart';
import 'package:tunder/presenter/i_mes_demandes.dart';

class MesDemandesPresenter {
  ImesDemandes mesDemandeView;
  late IdemandeRepository demandeRepository = HttpDemandeRepository();

  MesDemandesPresenter(this.mesDemandeView);

  Future<List<Demande>> getMyWaitingDemande() {
    return demandeRepository.getMyWaitingDemande();
  }
}
