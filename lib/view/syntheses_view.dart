import 'package:flutter/material.dart';
import 'package:tunder/presenter/i_synthese.dart';
import 'package:tunder/view/rendez_vous.dart';

import '../model/cours.dart';
import '../presenter/synthese_presenter.dart';
import 'add_synthese.dart';

class SynthesePage extends StatefulWidget {
  const SynthesePage({super.key});

  @override
  State<SynthesePage> createState() => _SynthesePageState();
}

class _SynthesePageState extends State<SynthesePage> implements ISyntheseView{
  late SynthesePresenter presenter;
  late Future<List<Cours>> coursGivenBloc;
  String blocSelected = "B1";

  _SynthesePageState() {
    presenter = SynthesePresenter(this);
    coursGivenBloc = presenter.getAllClasses(blocSelected);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Syntheses"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AddSynthesePage(presenter: presenter, coursBloc : coursGivenBloc)));
                    },
                  child: Icon(
                    Icons.add,
                  ),
                )
            ),
          ],
    ),
    );
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
  void displayError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
      elevation: 30,
    ));
  }
}