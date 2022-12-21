import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunder/presenter/mes_demande_presenter.dart';

import '../view/navigation.dart';

class DetailDemande extends StatelessWidget {
  const DetailDemande(
      {super.key,
      required this.nom,
      required this.prenom,
      required this.cours,
      required this.date,
      required this.lieu,
      required this.presenter,
      required this.id,
      required this.etat, required this.gestionnaire});

  final String nom, prenom, cours, date, lieu, etat,gestionnaire;
  final int id;
  final MesDemandesPresenter presenter;

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
            SvgPicture.asset(
              "assets/icons/meeting.svg",
              width: 500,
              height: 200,
              //color: Colors.grey,
            ),
            SizedBox(height: 32),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Nom : ',
                      style:  TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: nom),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                 const  TextSpan(
                      text: 'Prenom : ',
                      style:  TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: prenom),
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
                 const TextSpan(
                      text: 'Cours : ',
                      style:  TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: cours),
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
                  const TextSpan(
                      text: 'Date : ',
                      style:  TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: date),
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
                  const TextSpan(
                      text: 'Envoyé a : ',
                      style:  TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: gestionnaire),
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
                  const TextSpan(
                      text: 'Lieu : ',
                      style:  TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: lieu),
                ],
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                if (lieu.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Aucun rendez vous n'a été trouvé"),
                    backgroundColor: Colors.red,
                    elevation: 30,
                  ));
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationPage(lieu: lieu)),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              label: const Text('Aller au Rendez vous'),
              icon: Icon(Icons.navigation_outlined),
            ),
            SizedBox(height: 10),

            if(etat != "waiting" || presenter.isUser(prenom.toString()))
              ...[ Text(
                etat,
                style: const TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  fontSize: 22,
                ),
              )
              ]
            else ...[
                    ElevatedButton.icon(
                            onPressed: () {
                              presenter.updateStatus(id, 1);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreen,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            label: const Text('Confirmer'),
                            icon: Icon(Icons.done_outline),
                          ),
                    ElevatedButton.icon(
                      onPressed: () {
                              presenter.updateStatus(id, 0);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            label: const Text('Refuser'),
                            icon: Icon(Icons.remove_done),
                          ),
                      ]
          ],
        ),
      ),
    );
  }
}
