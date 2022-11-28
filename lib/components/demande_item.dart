import 'package:flutter/material.dart';
import 'package:tunder/components/details_demande.dart';

class DemandeItem extends StatefulWidget {
  const DemandeItem(
      {super.key,
      required this.nom,
      required this.prenom,
      required this.cours,
        required this.date,
        required this.lieu});
  final String nom, prenom, cours, date, lieu;

  @override
  State<DemandeItem> createState() => _DemandeItemState();
}

class _DemandeItemState extends State<DemandeItem> {
  _DemandeItemState();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 60, 59, 59), width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: width * 0.20,
              height: 50,
              child: Text("${widget.nom} ${widget.prenom}",
              style: const TextStyle(fontWeight: FontWeight.bold),)),
          SizedBox(width: width * .05),
          SizedBox(width: width * .25, height: 50, child: Text(widget.cours,style: const TextStyle(fontWeight: FontWeight.bold),)),
          SizedBox(width: width * .05),
          SizedBox(width: width * .05),
          SizedBox(width: width * .05),
          SizedBox(width: width * .05),
          SizedBox(
              width: width * .20,
              height: 30,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  DetailDemande(
                        nom: widget.nom,
                        prenom: widget.prenom,
                        cours: widget.cours,
                        date: widget.date,
                        lieu: widget.lieu,
                      )),
                    );
                  },

                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(
                         Colors.lightBlue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)))),
                  child: const Text("Details"))),
          SizedBox(width: width * .01),
        ],
      ),
    );
  }
}
