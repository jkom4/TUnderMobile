import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackbarCustom{
  SnackbarCustom._();
  static showSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
            padding: EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
              color : Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                  "Information !",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    )
                ),
              ],
            )

        ),
      ),
    );
  }
}