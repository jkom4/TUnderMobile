import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tunder/presenter/horaire_presenter.dart';
import 'package:tunder/presenter/i_horaire.dart';

///Cette vue permet d'afficher l'horaire
class Horaire extends StatefulWidget {
  const Horaire({super.key});

  @override
  State<Horaire> createState() => _HoraireState();
}

class _HoraireState extends State<Horaire> implements IHoraire {
  late HorairePresenter presenter;

  _HoraireState() {
    presenter = HorairePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Horaire"),
      ),
      body: FutureBuilder(
        future: presenter.getHoraire(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return SfCalendar(
              headerHeight: 70,
              todayHighlightColor: Colors.grey,
              dataSource:   presenter.getData(snapshot.data),
              view: CalendarView.workWeek,
              timeZone: 'W. Europe Standard Time',
              timeSlotViewSettings: const TimeSlotViewSettings(
                  startHour: 7,
                  endHour: 22,
                  nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                  timeInterval: Duration(hours: 2),
                  timeIntervalHeight: 100),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void displayError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
      elevation: 30,
    ));
  }
}
