import 'package:flutter/material.dart';

class ButtonTUnder extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;
  final Function callback;
  const ButtonTUnder(
      {Key? key,
      required this.width,
      required this.height,
      required this.color,
      required this.child,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
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
