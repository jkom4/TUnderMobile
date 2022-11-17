class Utilisateur {
  late String prenom;
  late String nom;
  late String email;

  Utilisateur(String prenom, String nom, String email) {
    setNom = nom;
    setPrenom = prenom;
    setEmail = email;
  }

  Utilisateur.fromJson(Map<String, dynamic> json) {
    setNom = json['nom'];
    setPrenom = json['prenom'];
    setEmail = json['email'];
  }

  String get getNom {
    return nom;
  }

  set setNom(String nom) {
    if (nom.isNotEmpty) {
      this.nom = nom;
    }
  }

  String get getPrenom {
    return prenom;
  }

  set setPrenom(String prenom) {
    if (prenom.isNotEmpty) {
      this.prenom = prenom;
    }
  }

  String get getEmail {
    return email;
  }

  set setEmail(String email) {
    if (email.isNotEmpty) {
      this.email = email;
    }
  }
}
