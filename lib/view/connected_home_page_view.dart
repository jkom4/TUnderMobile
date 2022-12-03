import 'package:flutter/material.dart';
import 'package:tunder/components/message_loby.dart';
import 'package:tunder/view/demande_tutorat_view.dart';
import 'package:tunder/view/horaire_view.dart';
import 'package:tunder/view/mes_demandes_view.dart';
import 'package:tunder/view/messages_view.dart';
import 'package:tunder/view/profil_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int indexPage = 0;
  final screens = [
    MesDemandes(),
    DemandeTutorat(),
    Messaging(),
    ProfilPage(),
    Horaire()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: indexPage,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 8,
          unselectedFontSize: 8,
          elevation: 0,
          selectedItemColor: Color.fromARGB(255, 0, 0, 0),
          currentIndex: indexPage,
          onTap: (index) => setState((() => indexPage = index)),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_copy_outlined),
              label: "Mes demandes",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.queue_sharp), label: "Demande tutorat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.messenger), label: "Messages"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: "Horaire"),
          ],
        ));
  }
}
