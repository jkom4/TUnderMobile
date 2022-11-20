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
      body: Column(children: <Widget>[
        const SizedBox(
          height: 40,
        ),
        const TitlePage(title: "Mes demandes en attentes"),
        FutureBuilder(
          future: mesDemandePresenter.getMyWaitingDemande(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return Container();
            } else if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return const Center(
                  child: Text('Auncun demande en attente!'),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Demande demande = snapshot.data[index];
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        DemandeItem(
                            nom: demande.getDemandeur!,
                            prenom: demande.getDemandeur!,
                            cours: demande.cours.getNom)
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
}
