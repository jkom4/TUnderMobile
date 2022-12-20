import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:tunder/presenter/i_synthese.dart';
import '../presenter/synthese_presenter.dart';
import 'add_synthese.dart';

/**
 * Cette vue liste les cours pour acceder aux synthèses
 */
class SynthesePage extends StatefulWidget {
  const SynthesePage({super.key});

  @override
  State<SynthesePage> createState() => _SynthesePageState();
}

class _SynthesePageState extends State<SynthesePage> implements ISyntheseView {
  late SynthesePresenter presenter;
  late Future<List> coursGivenBloc;
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
                      MaterialPageRoute(
                          builder: (context) => AddSynthesePage(
                              presenter: presenter,
                              coursBloc: coursGivenBloc)));
                },
                child: Icon(
                  Icons.add,
                ),
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: FutureBuilder(
                future: presenter.getAllCours(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    //displayError(snapshot.error.toString());
                    debugPrint("error View " + snapshot.error.toString());
                    return Container();
                  } else if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return const Center(
                        child: Text('Aucun Cours!'),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          final cours = snapshot.data[index];
                          return Card(
                            child: ListTile(
                              title: Text('${cours.bloc} ${cours.getNom} '),
                              trailing: const Icon(Icons.arrow_right_alt_sharp),
                              onTap: () async {
                                await presenter
                                    .synthesesForCours(cours)
                                    .then((value) {
                                  var syntheses = value;
                                  if (syntheses.isEmpty) {
                                    displayError(
                                        "Aucune synthèses n'a été trouvée !");
                                  } else if (syntheses.isNotEmpty) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ListSynthese(
                                                syntheses: syntheses,
                                                presenter: presenter)));
                                  }
                                });
                              },
                            ),
                          );
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
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

/**
 * Cette classe permet de lister les synthèses propres a un cours
 */
class ListSynthese extends StatelessWidget {
  const ListSynthese({
    Key? key,
    required this.syntheses,
    required this.presenter,
  }) : super(key: key);

  final List syntheses;
  final SynthesePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syntheses'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: syntheses.length,
                  itemBuilder: (context, index) {
                    final synthese = syntheses[index];

                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.note_alt_sharp),
                        title: Text(' Synthese ${synthese.getCreationDate.toString()} '),
                        subtitle: Text('${synthese.getAutheurOf}  ${synthese.getCreationDate} '),
                        onTap: () async {
                          await presenter
                              .downloadFile(synthese.getUrl)
                              .then((file) {
                                //Ouvrir le fichier une fois qu'il est recuperé
                            OpenFile.open(file.path);
                          });
                        },
                      ),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
