import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tunder/components/messages.dart';

class Messaging extends StatefulWidget {
  const Messaging({super.key});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final String email = "E190997@protonmail.com";
  final fs = FirebaseFirestore.instance;
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .85,
            child: Messages(email: email),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: message,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 210, 206, 206),
                    hintText: 'message',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSaved: (value) {
                    message.text = value!;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  if (message.text.isNotEmpty) {
                    fs.collection('messages').doc().set({
                      'text': message.text.trim(),
                      'createdAt': DateTime.now(),
                      'email': email,
                    });

                    message.clear();
                  }
                },
                icon: const Icon(Icons.send),
              ),
            ],
          )
        ],
      )),
    );
  }
}
