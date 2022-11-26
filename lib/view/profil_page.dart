

import 'package:flutter/material.dart';
import 'package:tunder/Model/userSession.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/presenter/connexion_presenter.dart';
import '../components/button_tunder.dart';
import '../components/snackbar.dart';
import '../presenter/i_connexion.dart';
import 'my_homePage.dart';

class ProfilPage extends StatefulWidget {

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> implements IConnexionView {
  late ConnexionPresenter _presenter = ConnexionPresenter(this);
  @override
  Widget build(BuildContext context) {
    final user = _presenter.currentUser();
    //final user = new Utilisateur("prenom", "nom", "email");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),

            SizedBox(height: 8),
            Text(
              'Nom : ' + user!.getNom,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Email : ' + user!.getEmail,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),

            ButtonTUnder(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              child: const Text("Se deconnecter"),
              callback: () {
                _presenter.logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void showMessage(String message) {
    SnackbarCustom.showSnackBar(context, message);
  }


  @override
  void refresh() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage()));
  }
}
 
