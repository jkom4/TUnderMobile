import 'package:json_annotation/json_annotation.dart';

part 'cours.g.dart';

@JsonSerializable()
class Cours {
  late String nom;
  late String bloc;

  Cours(String? nom, String bloc) {
    setNom = nom;
    setBloc = bloc;
  }

  factory Cours.fromJson(Map<String, dynamic> json) => _$CoursFromJson(json);

  Map<String, dynamic> toJson() => _$CoursToJson(this);

  String get getNom {
    return nom;
  }

  set setNom(String? nom) {
    if (nom == null) {
      throw Exception("Nom de cours ne peut etre nul");
    } else {
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
