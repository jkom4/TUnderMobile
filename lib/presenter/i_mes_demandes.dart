 /**
   * Cette classe est l'interface de la vue de demande de tutorat
   */

abstract class ImesDemandes {
  /**
   * Permet d'afficher les messages d'erreur
   */
  void displayError(String errorMessage);
  /**
   * Permet d'afficher les messages de confirmation
   */
  void displayConfirmation(String confirmationMessage);

  /**
   * Permet de rafraichir la vue
   */
  void refresh();
}
