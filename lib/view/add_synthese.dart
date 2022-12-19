import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tunder/components/blocs_dropdown.dart';
import 'package:tunder/components/button_tunder.dart';
import 'package:tunder/presenter/synthese_presenter.dart';
import '../components/cours_dropdown.dart';

///Cette vue permet a l'utilisateur d'ajouter une nouvelle synthèse
class AddSynthesePage extends StatefulWidget {
  const AddSynthesePage({Key? key, required this.presenter, required this.coursBloc}) : super(key: key);
  final SynthesePresenter presenter;
  final Future<List> coursBloc;

  @override
  State<AddSynthesePage> createState() => _AddSyntheseState();
}

class _AddSyntheseState extends State<AddSynthesePage> {
  late Future<List> coursGivenBloc = widget.coursBloc;
  String blocSelected = "B1";
  String? coursSelected;
  FilePickerResult? result;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une Synthèse"),
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                blocsDropdown(_updateCoursGivenBlocState),
                SizedBox(height: 8),
                coursDropdown(coursGivenBloc, _updateTutorGivenCoursState),
                ButtonTUnder(
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.lightBlue,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: const Text("Choisir un fichier"),
                    callback: () async {
                       result = await FilePicker.platform.pickFiles();

                    }
                ),
                SizedBox(height: 8),
                ButtonTUnder(
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: const Color.fromARGB(220, 95, 95, 95),
                  height: MediaQuery.of(context).size.width * 0.15,
                  child: const Text("Envoyer"),
                  callback: () {
                    widget.presenter.addSynthese(blocSelected ,coursSelected,result);
                  }

                ),
              ]),
        ),
      ),
    );
  }

  void _updateCoursGivenBlocState(String blocName) {
    setState(() {
      coursGivenBloc = widget.presenter.getAllClasses(blocName);
      blocSelected = blocName;
      coursSelected = null;
    });
  }
  void _updateTutorGivenCoursState(String courseName) {
    coursSelected = courseName;
  }

}