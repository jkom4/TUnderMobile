import 'package:tunder/model/demande.dart';

class Rencontre {
  late DateTime date;
  late String addresse;

  Rencontre(this.date, this.addresse);

  Rencontre.fromJson(json) {
    setAddresse = json["addresse"];
    setDate = json["date"];
  }

  set setDate(DateTime date) {
    this.date = date;
  }

  DateTime get getDate {
    return date;
  }

  set setAddresse(String addresse) {
    this.addresse = addresse;
  }

  String get getAddresse {
    return addresse;
  }
}
