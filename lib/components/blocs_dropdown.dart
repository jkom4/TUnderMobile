import 'package:flutter/material.dart';

Widget blocsDropdown() {
  const List<DropdownMenuItem<String>> blocs = [
    DropdownMenuItem(child: Text("B1"), value: "Bloc1"),
    DropdownMenuItem(child: Text("B2"), value: "Bloc2"),
    DropdownMenuItem(child: Text("B3"), value: "Bloc3"),
    DropdownMenuItem(child: Text("M1"), value: "Master1"),
    DropdownMenuItem(child: Text("M2"), value: "Master2"),
  ];
  String blocSelected = blocs.first.value!;
  return Row(children: [
    const Flexible(child: Text("Bloc")),
    const SizedBox(
      width: 50,
      height: 140,
    ),
    Flexible(
        child: DropdownButtonFormField(
      decoration: const InputDecoration(label: Text("Bloc")),
      value: blocSelected,
      items: blocs,
      onChanged: (String? value) {
        blocSelected = value!;
      },
    ))
  ]);
}
