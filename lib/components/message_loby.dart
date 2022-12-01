import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tunder/components/messages.dart';

class MessageLoby extends StatefulWidget {
  final String coursName;
  final String usrEmail;

  const MessageLoby(
      {super.key, required this.usrEmail, required this.coursName});

  @override
  State<MessageLoby> createState() => _MessageLobyState();
}

class _MessageLobyState extends State<MessageLoby> {
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
            height: MediaQuery.of(context).size.height * .91,
            child:
                Messages(email: widget.usrEmail, coursName: widget.coursName),
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
                    fs.collection(widget.coursName).doc().set({
                      'text': message.text.trim(),
                      'createdAt': DateTime.now(),
                      'email': widget.usrEmail,
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
