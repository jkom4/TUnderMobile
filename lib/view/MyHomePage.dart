import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/button_tunder.dart';
import '../components/social_icon.dart';
import '../components/text_field_container.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             const TextFieldContainer(
              child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black54,
                      ),
                      hintText: "Login")),
            ),
             const TextFieldContainer(
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    hintText: "Password",
                  ),
                )),
            ButtonTUnder(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text("Connexion"),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                children: <Widget>[
                  buildExpanded(),
                  Text(
                    "OU",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  buildExpanded(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  src: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  src: "assets/icons/google.svg",
                  press: () {},
                ),
                SocialIcon(
                  src: "assets/icons/linkedin.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: Divider(
        color: Colors.black,
        height: 1.5,
      ),
    );
  }
}