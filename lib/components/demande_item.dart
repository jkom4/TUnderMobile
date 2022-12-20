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
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.school_outlined),
            title: Text('${widget.prenom} '),
            subtitle: Text('${widget.cours}      Statut : ${widget.etat}',),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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
          widget.isUser // Si il s'agit du demandeur alors il peut que annuler ou voir les details
                ?

                    widget.etat =='waiting' // Si la demande n'est pas en attente alors il peut pas l'annuler
                        ?

                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.red),
                      child: const Text('Annuler'),
                      onPressed: () {
                        showDialog(context: context,
                            builder: (context)=> AlertDialog(
                              title: const Text("Avertissement"),
                              content: const Text("Êtes vous sur de vouloir annuler la demande?"),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context),
                                    child: const Text('Non')),
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                  widget.presenter.updateStatus(widget.id, 2);

                                    },
                                    child: const Text('Oui'))
                              ],
                            ));
                      },
                    )
                        :
                        ///N'affiche rien dans le cas ou la demande a déja été traité

                    const SizedBox(width: 8)

                :

                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent),
                      child: const Text('Refuser'),
                      onPressed: () {
                        widget.presenter.updateStatus(widget.id, 0);
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.lightBlue),
                      child: const Text('Accepter'),
                      onPressed: () {
                        widget.presenter.updateStatus(widget.id, 1);
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