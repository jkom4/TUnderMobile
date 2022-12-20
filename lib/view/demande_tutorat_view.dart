import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tunder/components/blocs_dropdown.dart';
import 'package:tunder/components/button_tunder.dart';
import 'package:tunder/components/comment_textfield.dart';
import 'package:tunder/components/cours_dropdown.dart';
import 'package:tunder/components/tutor_dropdown.dart';
import 'package:tunder/presenter/i_demande_tutorat.dart';
import 'package:tunder/presenter/demande_presenter.dart';
import 'package:tunder/view/rendez_vous.dart';

import 'my_homePage.dart';

///Cette vue permet de faire une demande de tutorat
class DemandeTutorat extends StatefulWidget {
  const DemandeTutorat({Key? key}) : super(key: key);

  @override
  State<DemandeTutorat> createState() => _DemandeTutoratState();
}

class _DemandeTutoratState extends State<DemandeTutorat>
    implements IdemandeTutorat {

  String? date;
  String? lieu;
  late DemandePresenter demandePresenter;
  late Future<List> coursGivenBloc;
  Future<List>? tutorGivenCours;
  String blocSelected = "B1";
  String? coursSelected, tutorSelected, comment;

  _DemandeTutoratState() {
    demandePresenter = DemandePresenter(this);
    coursGivenBloc = demandePresenter.getAllClasses(blocSelected);
  }

  void _updateCoursGivenBlocState(String blocName) {
    setState(() {
      coursGivenBloc = demandePresenter.getAllClasses(blocName);
      blocSelected = blocName;
      coursSelected = null;
      tutorSelected = null;
    });
  }

  void _updateTutorGivenCoursState(String courseName) {
    setState(() {
      tutorGivenCours =
          demandePresenter.getTutorForClasses(blocSelected, courseName);
      coursSelected = courseName;
      tutorSelected = null;
    });
  }

  void _updateSelectedTutor(String tutorname) {
    tutorSelected = tutorname;
    debugPrint(tutorname);
  }

  void _updateComment(String comment) {
    this.comment = comment;
    debugPrint(this.comment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demande de tutorat"),
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Form(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            blocsDropdown(_updateCoursGivenBlocState),
            coursDropdown(coursGivenBloc, _updateTutorGivenCoursState),
            tutorDropdown(tutorGivenCours, _updateSelectedTutor),
            commentText(_updateComment),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 0,
                  height: 10,
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    navigateAndGetRencontre(context).then((value) {
                     var json =  jsonDecode(value);
                     date = json['date'];
                     lieu = json['lieu'];
                    }
                    );
                  },
                  child: const Text('Fixer un rendez-vous'),
                ),
                SizedBox(height: 8),
                ButtonTUnder(
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: const Color.fromARGB(220, 95, 95, 95),
                    height: MediaQuery.of(context).size.width * 0.15,
                    callback: () {
                      debugPrint(blocSelected);
                      debugPrint(coursSelected);
                      debugPrint(tutorSelected);
                      debugPrint(date);
                      debugPrint(lieu);
                      demandePresenter.confirmForm(blocSelected, coursSelected,
                          tutorSelected, comment, date, lieu);
                    },

                    child: const Text("Demander")),
              ],
            )
          ],
        ))),
      ),
    );
  }

  Future<String> navigateAndGetRencontre(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RendezVousPage()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return "" ;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
    return result;
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
        MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }
}
