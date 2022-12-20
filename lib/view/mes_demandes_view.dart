import 'package:flutter/material.dart';
import 'package:tunder/components/demande_item.dart';
import 'package:tunder/presenter/mes_demande_presenter.dart';
import 'package:tunder/presenter/i_mes_demandes.dart';
///
/// Cette vue affiche la liste des demandes en attentes
class MesDemandes extends StatefulWidget {
  const MesDemandes({super.key});

  @override
  State<MesDemandes> createState() => _MesDemandesState();
}

class _MesDemandesState extends State<MesDemandes> implements ImesDemandes {
  late MesDemandesPresenter mesDemandePresenter;
  List demandeList = [];
  var trie = false;
  var id = 1;

  _MesDemandesState() {
    mesDemandePresenter = MesDemandesPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes demandes en attentes"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          FutureBuilder(
            future: mesDemandePresenter.getMyWaitingDemande(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                //displayError(snapshot.error.toString());
                return Container();
              } else if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return const Center(
                    child: Text('Aucune demande en attente!'),
                  );
                }
                return
                  Column(
                  children: [
                    Row(

                      children: [
                        const SizedBox(width: 40),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.sort),
                              tooltip: 'Trier par date',
                              onPressed: () {
                                setState(() {
                                  id = mesDemandePresenter.sort(snapshot.data,id);
                                  demandeList = snapshot.data;
                                  trie = true;
                                });
                              },
                            ),
                            const Text("Trier par date"),
                          ],
                        ),
                        const SizedBox(width: 130),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.sort_by_alpha),
                              tooltip: 'Trier par statut',
                              onPressed: () {
                                setState(() {

                                  id = mesDemandePresenter.sortByStatut(snapshot.data,id);
                                  demandeList = snapshot.data;
                                  trie = true;
                                });
                              },
                            ),
                            const Text("Trier par statut"),
                          ],
                        ),
                      ],
                    ),
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var demande =
                              trie ? demandeList[index] : snapshot.data[index];
                          return Column(
                            children: [
                              const SizedBox(height: 10),
                              //on l'envoie au component qui permet d'afficher chaque element
                              DemandeItem(
                                id: demande.id,
                                nom: demande.getDemandeur.toString(),
                                prenom: demande.getDemandeur.toString(),
                                cours: demande.cours.getNom,
                                date: demande.getRencontre.getDate.toString(),
                                lieu: demande.getRencontre.getAddresse,
                                isUser: mesDemandePresenter
                                    .isUser(demande.getDemandeur.toString()),
                                etat: demande.etat,
                                presenter: mesDemandePresenter,
                              ),
                            ],
                          );
                        }),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ]),
      ),
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

  @override
  void refresh() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => MesDemandes()));
  }
}
