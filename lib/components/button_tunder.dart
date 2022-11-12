import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonTUnder extends StatelessWidget {
  final double width;
  final Widget child;
  final Function callback;
  const ButtonTUnder(
      {Key? key,
      required this.width,
      required this.child,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          callback();
        },
        child: child,
      ),
    );
  }
}
