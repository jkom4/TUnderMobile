


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tunder/view/login_page.dart';
import 'package:tunder/view/connected_home_page_view.dart';

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }else if(snapshot.hasData){
          return Home();
        }else if(snapshot.hasError){
          return Center(child: Text('Echec de Connexion ! '));
        }else {
          return LoginPage(title: "Connexion");
        }
      },
    ),

  );
  
}