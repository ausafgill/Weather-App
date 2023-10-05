import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/utils/routes/utils.dart';

class GoogleAuth {
  signInwithGoogle(BuildContext context) async {
    //openwindow
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
//getAuthentication
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new credential for user from his selected gmail
    final credentials = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    return FirebaseAuth.instance
        .signInWithCredential(credentials)
        .then((value) {
      Utils().showErrorFlushBar('Logging In as ${value.user!.email.toString()}',
          context, Icon(Icons.login), Colors.green);
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, 'home_screen');
      });
    });
  }
}
