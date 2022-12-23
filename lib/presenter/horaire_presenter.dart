import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tunder/model/meeting.dart';
import 'package:tunder/model/meeting_data_source.dart';
import 'package:tunder/presenter/i_horaire.dart';
import 'package:tunder/repository/demande_repository.dart';
import 'package:tunder/repository/horaire_repository.dart';
import 'package:tunder/repository/i_demande_repository.dart';
import 'package:tunder/repository/i_horraire_repository.dart';

///Cette classe permet de gerer les horaires
class HorairePresenter {
  IHoraire horaireView;
  late IdemandeRepository demandeRepository = HttpDemandeRepository();
  late IHoraireRepository horaireRepository = HoraireRepository();
  List<Meeting> meetings = <Meeting>[];

  ///Construteur prend en parametre la vue horaire
  HorairePresenter(this.horaireView);

  ///Permet de recuperer l'horaire de l'utilisateur
  ///return Future
  Future getHoraire() async {
    await addRdvToCalendar();
    return horaireRepository.fetchUsrHoraire();
  }

  ///Permet d'ajouter le rendez vous de l'utilisateur dans le calendrier
  Future addRdvToCalendar() async {
    await demandeRepository.fetchRendezVous().then((rendezVous) {
      for (var rdv in rendezVous) {
        DateFormat dateFormat = DateFormat("dd-MM-yy HH:mm:ss");
        meetings.add(Meeting(
            "[RDV] : " +
                rdv['sujet'] +
                " : " +
                rdv['demandeur'] +
                " " +
                rdv['addresse'],
            dateFormat.parse(rdv['date']),
            dateFormat.parse(rdv['date']).add(Duration(hours: 2)),
            Colors.redAccent,
            false));
        debugPrint(rdv.toString());
      }
    }).catchError((onError) => debugPrint(onError.toString()));
  }

  ///Permet de traiter les données qui ont été recuperé de l'url de l'horaire et les ajouter dans l'objet Meeting
  ///params String calendar
  ///return MeetingDataSource
  MeetingDataSource getData(String calendar) {
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
