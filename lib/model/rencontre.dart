import 'package:json_annotation/json_annotation.dart';
import 'package:tunder/model/demande.dart';

part 'rencontre.g.dart';

@JsonSerializable()
class Rencontre {
  late DateTime date;
  late String addresse;

  Rencontre(DateTime? date, String? addresse) {
    setDate = date;
    setAddresse = addresse;
  }

  factory Rencontre.fromJson(Map<String, dynamic> json) =>
      _$RencontreFromJson(json);

  Map<String, dynamic> toJson() => _$RencontreToJson(this);

  set setDate(DateTime? date) {
    if (date == null) {
      this.date = DateTime.fromMicrosecondsSinceEpoch(0);
    } else {
      this.date = date;
    }
  }

  DateTime get getDate {
    return date;
  }

  set setAddresse(String? addresse) {
    if (addresse == null) {
      this.addresse = "";
    } else {
      this.addresse = addresse;
    }
  }

  String get getAddresse {
    return addresse;
  }
}
