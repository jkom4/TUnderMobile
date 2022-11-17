import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tunder/Model/token.dart';
import 'package:tunder/view/connected_home_page_view.dart';
import 'package:tunder/view/connexion_view.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (UserSession.instance?.getUserSession != null ||
                snapshot.hasData) {
              return Home();
            } else if (snapshot.hasError) {
              return Center(child: Text('Echec de Connexion ! '));
            } else {
              return LoginPage(title: "Connexion");
            }
          },
        ),
      );
}
