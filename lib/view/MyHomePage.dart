import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunder/presenter/connexion_presenter.dart';
import 'package:tunder/presenter/i_connexion_view.dart';
import '../components/button_tunder.dart';
import '../components/social_icon.dart';
import '../components/text_field_container.dart';
import '../components/snackbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

 class _MyHomePageState extends State<MyHomePage> implements IConnexionView {
  late ConnexionPresenter _presenter;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  _MyHomePageState(){
    _presenter =  ConnexionPresenter(this);

  }



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
              TextFieldContainer(
              child: TextField(
                  controller : emailController,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black54,
                      ),
                      hintText: "Login")),
            ),
              TextFieldContainer(
                child: TextField(
                  controller : passwordController ,
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
              press: () {

                _presenter.Connect(emailController.text, passwordController.text);
                },
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
                  press: () {
                    //_presenter.googleConnect();
                  },
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

  @override
  void ShowMessage(String message) {
    SnackbarCustom.showSnackBar(context,message);
  }

}