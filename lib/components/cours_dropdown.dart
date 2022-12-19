import 'package:flutter/material.dart';

Widget coursDropdown(Future<List> givenCours, Function callback) {
  List<DropdownMenuItem<String>> cours = List.empty(growable: true);
  String? selectedCours;
  return DropdownButtonHideUnderline(
      child: FutureBuilder<List>(
    future: givenCours,
    initialData: const [],
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        debugPrint(snapshot.error.toString());
        return Container();
      } else if (snapshot.hasData) {
        cours.clear();
        snapshot.data?.forEach((element) {
          cours.add(DropdownMenuItem(
            value: element.getNom,
            child: Text(element.getNom),
          ));
        });
        if (cours.isNotEmpty) {
          selectedCours = cours.first.value;
        }

        return Row(children: [
          const Flexible(child: Text("Cours")),
          const SizedBox(
            width: 43,
            height: 130,
          ),
          Flexible(
              child: DropdownButtonFormField(
            isExpanded: true,
            decoration: const InputDecoration(label: Text("Cours")),
            value: selectedCours,
            items: cours,
            menuMaxHeight: 200,
            hint: const Text("Choix d'un cours"),
            onChanged: (String? value) {
              selectedCours = value!;
              callback(selectedCours);
            },
          )),
        ]);
      } else {
        return const CircularProgressIndicator();
      }
    },
  ));
}
