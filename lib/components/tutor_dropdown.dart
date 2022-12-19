import 'package:flutter/material.dart';

Widget tutorDropdown(
    Future<List>? tutorGivenCours, Function callback) {
  List<DropdownMenuItem<String>> tutor = List.empty(growable: true);
  String? selectedTutor;
  return DropdownButtonHideUnderline(
      child: FutureBuilder<List>(
    future: tutorGivenCours,
    initialData: const [],
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        debugPrint(snapshot.error.toString());
        return Container();
      } else if (snapshot.hasData) {
        tutor.clear();
        snapshot.data?.forEach((element) {
          tutor.add(DropdownMenuItem(
            value: element.getEmail,
            child: Text("${element.getNom} ${element.getPrenom}"),
          ));
        });
        if (tutor.isNotEmpty) {
          selectedTutor = tutor.first.value;
        }
        return Row(children: [
          const Flexible(child: Text("Tuteurs")),
          const SizedBox(
            width: 40,
            height: 130,
          ),
          Flexible(
              child: DropdownButtonFormField(
            isExpanded: true,
            decoration: const InputDecoration(label: Text("Tuteur")),
            value: selectedTutor,
            items: tutor,
            menuMaxHeight: 200,
            onChanged: (String? value) {
              selectedTutor = value!;
              callback(selectedTutor);
            },
          ))
        ]);
      } else {
        return const CircularProgressIndicator();
      }
    },
  ));
}
