import 'package:flutter/material.dart';
import 'package:tunder/components/blocs_dropdown.dart';
import 'package:tunder/components/button_tunder.dart';
import 'package:tunder/components/comment_textfield.dart';
import 'package:tunder/components/cours_dropdown.dart';
import 'package:tunder/components/tutor_dropdown.dart';
import 'package:tunder/model/cours.dart';
import 'package:tunder/model/utilisateur.dart';
import 'package:tunder/presenter/i_demande_tutorat.dart';
import 'package:tunder/components/title_page.dart';
import 'package:tunder/presenter/demande_presenter.dart';

class DemandeTutorat extends StatefulWidget {
  const DemandeTutorat({Key? key}) : super(key: key);

  @override
  State<DemandeTutorat> createState() => _DemandeTutoratState();
}

class _DemandeTutoratState extends State<DemandeTutorat>
    implements IdemandeTutorat {
  late DemandePresenter demandePresenter;
  late Future<List<Cours>> coursGivenBloc;
  Future<List<Utilisateur>>? tutorGivenCours;
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
    const pageTitle = "Demande de tutorat";
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Form(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            const TitlePage(title: pageTitle),
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
                ButtonTUnder(
                    width: MediaQuery.of(context).size.width * 0.8,
                    callback: () {
                      debugPrint(blocSelected);
                      debugPrint(coursSelected);
                      debugPrint(tutorSelected);
                      demandePresenter.confirmForm(blocSelected, coursSelected,
                          tutorSelected, comment, null, "");
                    },
                    child: const Text("Demander")),
              ],
            )
          ],
        ))),
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
}
