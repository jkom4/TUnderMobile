import 'package:flutter/material.dart';

import '../view/navigation.dart';

class DetailDemande extends StatelessWidget {
  const DetailDemande(
      {super.key,
      required this.nom,
      required this.prenom,
      required this.cours,
      required this.date,
      required this.lieu});

  final String nom, prenom, cours, date, lieu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: 'Nom : ', style: const TextStyle(color: Colors.grey, fontSize: 16,fontWeight: FontWeight.bold)),
              TextSpan(text: nom ),
            ],
          ),
        ),

            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Prenom : ', style: const TextStyle(color: Colors.grey, fontSize: 16,fontWeight: FontWeight.bold)),
                  TextSpan(text: prenom ),
                ],
              ),
            ),

            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Cours : ', style: const TextStyle(color: Colors.grey, fontSize: 16,fontWeight: FontWeight.bold)),
                  TextSpan(text: cours ),
                ],
              ),
            ),

            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Date : ', style: const TextStyle(color: Colors.grey, fontSize: 16,fontWeight: FontWeight.bold)),
                  TextSpan(text: date ),
                ],
              ),
            ),

            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Lieu : ', style: const TextStyle(color: Colors.grey, fontSize: 16,fontWeight: FontWeight.bold)),
                  TextSpan(text: lieu ),
                ],
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage(title: "Navigation",
                    lieu : lieu)),);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
              ),
              label: const Text('Aller au Rendez vous'),
              icon : Icon(Icons.navigation_outlined),


            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              label: const Text('Confirmer'),
              icon : Icon(Icons.done_outline),
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              label: const Text('Refuser'),
              icon : Icon(Icons.remove_done),
            ),
          ],



        ),
      ),

    );
  }
}
