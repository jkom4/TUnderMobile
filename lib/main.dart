import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunder/view/connected_home_page_view.dart';
import 'package:tunder/view/connexion_view.dart';
import 'package:tunder/view/my_homePage.dart';


import 'package:tunder/model/demande.dart';
import 'package:tunder/view/demande_tutorat_view.dart';
import 'package:tunder/view/mes_demandes_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.development');
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
      home:  MyHomePage(),

    );
  }

}





