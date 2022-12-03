import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IConnexionRepository {
  Future signInWithGoogle();
  Future fetchLogin(String email, String password);
  Future fecthJwtForSigninGoogle(GoogleSignInAccount? currentUser);
  Future fetchUsrHoraire();
  Future getUsrLink();
  Future postUsrLink(String link);
  void logout() {}
}
