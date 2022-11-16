import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tunder/presenter/connexion_presenter.dart';
import 'package:tunder/view/i_connexion_view.dart';

import '../components/button_tunder.dart';

class ProfilPage extends StatelessWidget implements IConnexionView{
  late ConnexionPresenter _presenter = new ConnexionPresenter(this);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 32),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.photoURL!)
          ),
          SizedBox(height: 8),
          Text(
            'Nom : ' + user.displayName!,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Email : ' + user.email!,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: 8),
          ButtonTUnder(
            width: MediaQuery.of(context).size.width * 0.8,
            child: const Text("Se deconnecter"),
            callback: () {
              _presenter.logout();
            },
          ),
        ],),
      ),
    );
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
  }

  @override
  void showProfil(String url, String name, String email) {
    // TODO: implement showProfil
  }

}