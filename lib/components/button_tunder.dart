import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonTUnder extends StatelessWidget {
  final double width;
  final Widget child;
  final Function press;


  const ButtonTUnder({
    Key? key,
    required this.width,
    required this.child,
    required this.press,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      child:TextButton(
        style:  TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(fontSize: 20),
        ),

        onPressed:  () => press(),
        child: child,
      ),
    );
  }
}

