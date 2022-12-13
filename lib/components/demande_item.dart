import 'package:flutter/material.dart';
import 'package:tunder/components/details_demande.dart';
import 'package:tunder/presenter/mes_demande_presenter.dart';

class DemandeItem extends StatefulWidget {
  const DemandeItem(
      {super.key,
      required this.nom,
      required this.prenom,
      required this.cours,
      required this.date,
      required this.lieu,
      required this.isUser,
      required this.etat,
      required this.presenter,
      required this.id});

  final String nom, prenom, cours, date, lieu, etat;
  final int id;
  final bool isUser;
  final MesDemandesPresenter presenter;

  @override
  State<DemandeItem> createState() => _DemandeItemState();
}

class _DemandeItemState extends State<DemandeItem> {
  _DemandeItemState();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.school_outlined),
            title: Text('${widget.prenom} '),
            subtitle: Text('${widget.cours}      Status: ${widget.etat}',),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.isUser
                ? <Widget>[
                    const SizedBox(width: 8),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.lightBlue),
                      child: const Text('Fermer'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    const SizedBox(width: 8),
                  ]
                : <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.lightBlueAccent),
                      child: const Text('Details'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDemande(
                                    nom: widget.nom,
                                    prenom: widget.prenom,
                                    cours: widget.cours,
                                    date: widget.date,
                                    lieu: widget.lieu,
                                    presenter: widget.presenter,
                                    id: widget.id,
                                    etat: widget.etat,
                                  )),
                        );
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent),
                      child: const Text('Refuser'),
                      onPressed: () {
                        widget.presenter.updateStatus(widget.id, false);
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.lightBlue),
                      child: const Text('Accepter'),
                      onPressed: () {
                        widget.presenter.updateStatus(widget.id, true);
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
          ),
        ],
      ),
    );
  }
}