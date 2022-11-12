import 'package:flutter/material.dart';

Widget commentText(Function callback) {
  return Row(
    children: [
      const Flexible(child: Text("Commentaire")),
      const SizedBox(
        width: 20,
        height: 140,
      ),
      Flexible(
          child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        onChanged: (value) {
          callback(value.trim());
        },
      ))
    ],
  );
}
