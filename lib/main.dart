import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunder/view/MyHomePage.dart';
import 'package:tunder/view/demande_tutorat.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TUnder',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home:  const MyHomePage(title: 'Accueil',),
    );
  }
}




