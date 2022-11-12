import 'package:flutter/material.dart';

Widget inputText() {
  return Row(children: const [
    Flexible(child: Text("Cours")),
    SizedBox(
      width: 65,
      height: 140,
    ),
    Flexible(child: TextField())
  ]);
}
