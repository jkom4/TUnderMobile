class Cours {
  late int id;
  late String nom;
  late String bloc;

  Cours(String nom, String bloc) {
    setNom = nom;
    setBloc = bloc;
  }

  int get getId {
    return id;
  }

  set setId(int id) {
    if (id > 0) {
      this.id = id;
    }
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
