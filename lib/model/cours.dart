class Cours {
  late String nom;
  late String bloc;

  Cours(String nom, String bloc) {
    setNom = nom;
    setBloc = bloc;
  }
  Cours.fromJson(Map<String, dynamic> json) {
    setNom = json['nom'];
    setBloc = json['bloc'];
  }

  String get getNom {
    return nom;
  }

  set setNom(String nom) {
    if (nom.isNotEmpty) {
      this.nom = nom;
    }
  }

  String get getBloc {
    return bloc;
  }

  //regex to match B1,B2,B3,M1,M2
  set setBloc(String bloc) {
    if (nom.isNotEmpty) {
      bloc.toUpperCase();
      this.bloc = bloc;
    }
  }
}
