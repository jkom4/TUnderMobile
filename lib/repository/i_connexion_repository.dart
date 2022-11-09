
abstract class IConnexionRepository {
  Future fetchGoogleSign();
  Future fetchLogin(String email, String password);
}