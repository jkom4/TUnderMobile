import 'package:flutter/material.dart';
import 'package:tunder/components/blocs_dropdown.dart';
import 'package:tunder/components/title_page.dart';
import 'package:tunder/presenter/demande_presenter.dart';

class DemandeTutorat extends StatelessWidget {
  //final DemandePresenter _demandePresenter = DemandePresenter(this);

   DemandeTutorat({super.key});

  @override
  Widget build(BuildContext context) {
    const pageTitle = "Demande de tutorat";

    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(40),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const TitlePage(title: pageTitle),
          blocsDropdown(),
        ],
      )),
    ));
  }
}
