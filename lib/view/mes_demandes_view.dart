import 'package:flutter/material.dart';
import 'package:tunder/components/demande_item.dart';
import 'package:tunder/components/title_page.dart';
import 'package:tunder/model/demande.dart';
import 'package:tunder/presenter/mes_demande_presenter.dart';
import 'package:tunder/presenter/i_mes_demandes.dart';

class MesDemandes extends StatefulWidget {
  const MesDemandes({super.key});

  @override
  State<MesDemandes> createState() => _MesDemandesState();
}

class _MesDemandesState extends State<MesDemandes> implements ImesDemandes {
  late MesDemandesPresenter mesDemandePresenter;

  _MesDemandesState() {
    mesDemandePresenter = MesDemandesPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes demandes en attentes"),
      ),
      body: Column(children: <Widget>[
        const SizedBox(
          height: 40,
        ),
        FutureBuilder(
          future: mesDemandePresenter.getMyWaitingDemande(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              //displayError(snapshot.error.toString());
              debugPrint("error View " + snapshot.error.toString());
              return Container();
            } else if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return const Center(
                  child: Text('Aucune demande en attente!'),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Demande demande = snapshot.data[index];
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        DemandeItem(
                          id : demande.id,
                          nom: demande.getDemandeur.toString(),
                          prenom: demande.getDemandeur.toString(),
                          cours: demande.cours.getNom,
                          date: demande.getRencontre.getDate.toString(),
                          lieu: demande.getRencontre.getAddresse,
                          isUser: mesDemandePresenter.isUser(demande.getDemandeur.toString()),
                          etat: demande.etat,
                          presenter: mesDemandePresenter,
                        ),
                      ],
                    );
                  });
            } else {
              return const CircularProgressIndicator();
            }
          },
        )
      ]),
    );
  }

  @override
  void displayError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
      elevation: 30,
    ));
  }

  @override
  void displayConfirmation(String confirmationMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(confirmationMessage),
      backgroundColor: Colors.green,
      elevation: 30,
    ));
  }
}
