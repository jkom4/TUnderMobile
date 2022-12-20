/**
 * Cette classe est l'interface de la vue login
 */
abstract class IConnexionView{
  /**
   * Permet d'afficher un message d'information a l'utilisateur
   */
  void showMessage(String message);

  /**
   * Permet de rafraichir la vue
   */
  void refresh();
}