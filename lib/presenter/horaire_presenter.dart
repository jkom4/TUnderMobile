  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tunder/model/meeting.dart';
import 'package:tunder/model/meeting_data_source.dart';
import 'package:tunder/presenter/i_horaire.dart';
import 'package:tunder/repository/connexion_repository.dart';
import 'package:tunder/repository/i_connexion_repository.dart';

class HorairePresenter {
  IHoraire horaireView;
  late IConnexionRepository repository = ConnexionRepository();
  List<Meeting> meetings = <Meeting>[];

  HorairePresenter(this.horaireView);

  Future getHoraire() async {
    await addRdvToCalendar();
    return repository.fetchUsrHoraire();
  }


  Future addRdvToCalendar()  async {
     await repository.fetchRendezVous().then((rendezVous) {
      for(var rdv in rendezVous){
        DateFormat dateFormat = DateFormat("dd-MM-yy HH:mm:ss");
        meetings.add(
          Meeting("[RDV] : " + rdv['sujet'] + " : " + rdv['demandeur'] + " " + rdv['addresse'],
              dateFormat.parse(rdv['date']) , dateFormat.parse(rdv['date']).add(Duration(hours: 2)), Colors.redAccent, false)
        );
        print(rdv.toString());
      }
    }).catchError((onError) => print(onError));
  }

  MeetingDataSource getData(String calendar)  {
    var data = calendar.split('\\r\\n');
    debugPrint(data.length.toString());
    for (var i = 0; i < data.length; i++) {
      if (data[i].contains("SUMMARY")) {
        try {
          meetings.add(Meeting(
              data[i].split(':')[1],
              DateTime.parse(data[i - 3].split(':')[1]),
              DateTime.parse(data[i - 5].split(':')[1]),
              Colors.black54,
              false));
        } catch (e) {
          debugPrint(e.toString());
        }

      }
    }
    return MeetingDataSource(meetings);
  }


}
