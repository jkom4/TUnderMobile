import 'package:json_annotation/json_annotation.dart';
import 'package:tunder/model/utilisateur.dart';

import 'cours.dart';

part 'synthese.g.dart';

@JsonSerializable()
class Synthese {
  late int  id;
  DateTime? creationDate;
  late String fileName;
  String? autheurOf;
  late Cours cours;

  Synthese(int id, DateTime? creationDate, String fileName, String? autheurOf,
      Cours cours) {
    setId = id;
    setCreationDate = creationDate;
    setFileName = fileName;
    setAutheurOf = autheurOf;
    setCours = cours;
  }

  factory Synthese.fromJson(Map<String,dynamic> data) => _$SyntheseFromJson(data);

  Map<String,dynamic> toJson() => _$SyntheseToJson(this);

  int get getId {
    return id;
  }

  set setId(int id) {
    if (id > 0 ) {
      this.id = id;
    } else {
      this.id = 0;
    }
  }

  DateTime? get getCreationDate {
    return creationDate;
  }

  set setCreationDate(DateTime? creationDate) {
    if (creationDate != null) {
      this.creationDate = creationDate;
    } else {
      this.creationDate = null;
    }
  }

  String get getFileName {
    return  fileName;
  }

  set setFileName(String fileName) {
      this.fileName = fileName;
  }

  set setCours(Cours cours) {
    this.cours = cours;
  }

  Cours get getCours {
    return cours;
  }
  set setAutheurOf(String? autheurOf) {
    this.autheurOf = autheurOf;
  }

  String? get getAutheurOf {
    return autheurOf;
  }


}

