import 'package:tunder/model/demande.dart';

abstract class IdemandeRepository {
  Future<List<Demande>?> getMyWaitingDemande();
  Future addDemande(Demande demandeToAdd);
  Future updateStatus(Demande demandeToUpdate);
  Future<List> fetchRendezVous();
}
