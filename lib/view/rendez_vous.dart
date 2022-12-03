import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:tunder/components/constants.dart';
import 'package:tunder/model/rencontre.dart';
import '../components/button_tunder.dart';
import '../components/text_field_container.dart';

class RendezVousPage extends StatefulWidget {
  const RendezVousPage({Key? key}) : super(key: key);

  @override
  State<RendezVousPage> createState() => _RendezVousState();
}

class _RendezVousState extends State<RendezVousPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController heureController = TextEditingController();
  TextEditingController lieuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fixer un rendez-vous"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFieldContainer(
                child: TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        hintText: "Date"),
                    readOnly: true, // when true user cannot edit text
                    onTap: () async {
                      //when click we have to show the datepicker
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101),
                      );

                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(pickedDate!);
                    }),
              ),
              TextFieldContainer(
                child: TextField(
                    controller: heureController,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.black,
                        ),
                        hintText: "Heure"),
                    readOnly: true, // when true user cannot edit text
                    onTap: () async {
                      //when click we have to show the datepicker
                      TimeOfDay? pickedHeure = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(), //get today's date
                        builder: (context, child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child ?? Container(),
                          );
                        },
                      );
                      var df = DateFormat("h:mm a");
                      var dt = df.parse(pickedHeure!.format(context));
                      heureController.text = DateFormat('HH:mm').format(dt);
                    }),
              ),
              TextFieldContainer(
                child: TextField(
                  controller: lieuController,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      ),
                      hintText: "Adresse"),
                  onTap: () async {
                    Prediction? p = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: google_api_key,
                        mode: Mode.overlay, // Mode.fullscreen
                        offset: 0,
                        radius: 1000,
                        types: [],
                        strictbounds: false,
                        region: "be",
                        language: "fr",
                        components: [Component(Component.country, "be")]);

                    lieuController.text = p!.description!;
                    print(lieuController.text);
                  },
                ),
              ),
              ButtonTUnder(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.1,
                color: Colors.black,
                child: const Text("Envoyer"),
                callback: () {
                  String dateHeure =
                      dateController.text + " " + heureController.text;
                  Navigator.pop(context,
                      {"date": dateHeure, "lieu": lieuController.text});
                },
              ),
            ]),
      ),
    );
  }
}
