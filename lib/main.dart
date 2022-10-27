

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/button_tunder.dart';
import 'components/text_field_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUnder',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Tunder'),
    );
  }
}

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
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *0.02),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                children:  <Widget>[
                  buildExpanded(),
                  Text(
                    "OU",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                    ,),
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
                  press: (){},
                ),
                SocialIcon(
                  src: "assets/icons/google.svg",
                  press: (){},
                ),
                SocialIcon(
                  src:   "assets/icons/linkedin.svg",
                  press: (){},
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

class SocialIcon extends StatelessWidget {
  final String src;
  final Function press;
  const SocialIcon({
    Key? key, required this.src, required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
          shape: BoxShape.circle,
        ),
        child:SvgPicture.asset(
          src,
          width: 20,
          height: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}




