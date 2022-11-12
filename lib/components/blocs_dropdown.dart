import 'package:flutter/material.dart';

Widget blocsDropdown(Function callBack) {
  const List<DropdownMenuItem<String>> blocs = [
    DropdownMenuItem(child: Text("B1"), value: "B1"),
    DropdownMenuItem(child: Text("B2"), value: "B2"),
    DropdownMenuItem(child: Text("B3"), value: "B3"),
    DropdownMenuItem(child: Text("M1"), value: "M1"),
    DropdownMenuItem(child: Text("M2"), value: "M2"),
  ];
  String blocSelected = blocs.first.value!;
  return Row(children: [
    const Flexible(child: Text("Bloc")),
    const SizedBox(
      width: 45,
      height: 130,
    ),
    Flexible(
        child: DropdownButtonFormField(
      decoration: const InputDecoration(label: Text("Bloc")),
      value: blocSelected,
      items: blocs,
      menuMaxHeight: 200,
      onChanged: (String? value) {
        blocSelected = value!;
        callBack(value);
      },
    ))
  ]);
}
