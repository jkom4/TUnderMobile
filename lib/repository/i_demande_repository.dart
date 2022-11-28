import 'package:tunder/model/demande.dart';

abstract class IdemandeRepository {
  Future<List<Demande>?> getMyWaitingDemande();
  Future<List<Demande>> handleDemand();
  Future addDemande(Demande demandeToAdd);
}
