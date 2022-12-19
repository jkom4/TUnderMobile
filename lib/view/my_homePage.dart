import 'package:flutter/material.dart';
import 'package:tunder/Model/userSession.dart';
import 'package:tunder/view/connected_home_page_view.dart';
import 'package:tunder/view/connexion_view.dart';

///Cette classe permet d'afficher le state correspondant au status de l'utilisateur au demarrage de l'application
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: FutureBuilder(
          future: UserSessionProvider.getInstance?.get(key: "jwtToken"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const Home();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Echec de Connexion ! '));
            } else {
              return const LoginPage(title: "Connexion");
            }
          }));
}
