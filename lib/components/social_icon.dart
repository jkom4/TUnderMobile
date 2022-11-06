import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialIcon extends StatelessWidget {
  final String src;
  final Function press;
  const SocialIcon({
    Key? key,
    required this.src,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          src,
          width: 20,
          height: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}