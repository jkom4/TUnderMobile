import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  final String email;
  final String coursName;
  const Messages({super.key, required this.coursName, required this.email});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection(widget.coursName)
      .orderBy('createdAt')
      .limit(1000)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return Container();
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemBuilder: (_, index) {
              QueryDocumentSnapshot qs = snapshot.data!.docs[index];
              Timestamp t = qs['createdAt'];
              DateTime d = t.toDate();
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: widget.email == qs['email']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          qs['email'],
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                qs['text'],
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              "${d.hour}:${d.minute}",
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
