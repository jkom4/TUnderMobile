import 'package:flutter/material.dart';

class DemandeItem extends StatefulWidget {
  const DemandeItem(
      {super.key,
      required this.nom,
      required this.prenom,
      required this.cours});
  final String nom, prenom, cours;

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
              child: Text("${widget.nom} ${widget.prenom}")),
          SizedBox(width: width * .05),
          SizedBox(width: width * .25, height: 50, child: Text(widget.cours)),
          SizedBox(width: width * .05),
          SizedBox(
              width: width * .20,
              height: 30,
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(121, 80, 209, 84)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)))),
                  child: const Text("Accepter"))),
          SizedBox(width: width * .01),
          SizedBox(
              width: width * .20,
              height: 30,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(133, 173, 38, 28)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)))),
                child: const Text("Refuser"),
              ))
        ],
      ),
    );
  }
}
