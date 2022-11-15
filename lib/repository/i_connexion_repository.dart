
import '../Model/utilisateur.dart';

abstract class IConnexionRepository {
  Future signInWithGoogle();
  Future fetchLogin(String email, String password);
}