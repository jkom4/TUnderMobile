import 'package:tunder/model/demande.dart';
import 'package:tunder/model/environment.dart';
import 'package:tunder/repository/i_demande_repository.dart';

class HttpDemandeRepository implements IdemandeRepository {
  static final apiUrl = Environment.apiUrl;

  HttpDemandeRepository();

  @override
  Future<List<Demande>> handleDemand() {
    // TODO: implement handleDemand
    throw UnimplementedError();
  }

  @override
  Future<List<Demande>> getMyWaitingDemande() {
    // TODO: implement getMyWaitingDemande
    throw UnimplementedError();
  }
}
