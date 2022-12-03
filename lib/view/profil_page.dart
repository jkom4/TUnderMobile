import 'package:flutter/material.dart';
import 'package:tunder/components/text_field_container.dart';
import 'package:tunder/presenter/connexion_presenter.dart';
import '../components/button_tunder.dart';
import '../components/snackbar.dart';
import '../presenter/i_connexion.dart';
import 'my_homePage.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> implements IConnexionView {
  late final ConnexionPresenter _presenter = ConnexionPresenter(this);
  late Future data;
  TextEditingController linkControler = TextEditingController();

  @override
  void initState() {
    data = _presenter.getHoraireLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = _presenter.currentUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                debugPrint(snapshot.data);
                return ListView(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const SizedBox(height: 10),
                          Text(
                            'Nom: ${user.getNom}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Email: ${user.getEmail}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Lien Horaire: ${snapshot.data}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFieldContainer(
                              child: TextField(
                            controller: linkControler,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Lien horaire",
                            ),
                          )),
                          const SizedBox(height: 10),
                          ButtonTUnder(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.8,
                              color: const Color.fromARGB(220, 95, 95, 95),
                              child: const Text("Ajouter"),
                              callback: () {
                                _presenter.updateLink(linkControler.text);
                                data = _presenter.getHoraireLink();
                                setState(() {
                                  refresh();
                                });
                              }),
                          const SizedBox(height: 90),
                          ButtonTUnder(
                            height: MediaQuery.of(context).size.width * 0.16,
                            width: MediaQuery.of(context).size.width * 0.8,
                            color: Colors.black,
                            child: const Text("Se deconnecter"),
                            callback: () {
                              _presenter.logout();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                showMessage(snapshot.error.toString());
                return Container();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  @override
  void showMessage(String message) {
    SnackbarCustom.showSnackBar(context, message);
  }

  @override
  void refresh() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }
}
