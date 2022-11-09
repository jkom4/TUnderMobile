import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunder/view/MyHomePage.dart';
import 'package:tunder/view/demande_tutorat.dart';


void main() {
  HttpOverrides.global = new MyHttpOverrides();//A RETIRER AUSSI
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
//A RETIRER POUR LA PROD
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}




