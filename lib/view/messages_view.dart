import 'package:flutter/material.dart';
import 'package:tunder/components/message_loby.dart';
import 'package:tunder/components/title_page.dart';
import 'package:tunder/model/cours.dart';
import 'package:tunder/presenter/i_message.dart';
import 'package:tunder/presenter/message_presenter.dart';

class Messaging extends StatefulWidget {
  const Messaging({super.key});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> implements IMessagesView {
  late MessagePresenter messagePresenter;

  _MessagingState() {
    messagePresenter = MessagePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    List<Cours> coursList = List.empty(growable: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: FutureBuilder(
              future: messagePresenter.getAllCours(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return Container();
                } else if (snapshot.hasData) {
                  coursList.clear();
                  snapshot.data?.forEach((element) {
                    coursList.add(element);
                  });
                  return ListView.builder(
                    itemCount: coursList.length,
                    itemBuilder: (context, index) {
                      final cours = coursList[index];
                      return Card(
                        child: ListTile(
                          title: Text('${cours.bloc} ${cours.getNom}'),
                          trailing: const Icon(Icons.message_rounded),
                          onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MessageLoby(
                                    usrEmail: messagePresenter.getUsrMail(),
                                    coursName: cours.getNom)))
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
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
}
