import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tunder/Model/userSession.dart';
import 'package:tunder/presenter/i_connexion.dart';
import 'package:tunder/view/connected_home_page_view.dart';
import 'package:tunder/view/connexion_view.dart';

import '../presenter/connexion_presenter.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder(

          future: UserSessionProvider.getInstance?.get(key: "jwtToken"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Home();
            } else if (snapshot.hasError) {
              return Center(child: Text('Echec de Connexion ! '));
            } else {
              return LoginPage(title: "Connexion");
            }
          }
        )
      );







}
