import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rencontre.g.dart';

@JsonSerializable()
class Rencontre {
  late DateTime date;
  late String addresse;

  Rencontre(String? date, String? addresse) {
    setDate = date;
    setAddresse = addresse;
  }

  factory Rencontre.fromJson(Map<String, dynamic> json) =>
      _$RencontreFromJson(json);

  Map<String, dynamic> toJson() => _$RencontreToJson(this);

  set setDate(String? date) {
    if (date == null) {
      this.date = DateTime.fromMicrosecondsSinceEpoch(0);
    } else {
      this.date = DateFormat("dd-MM-yyyy HH:mm", "en_US").parse(date);
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
