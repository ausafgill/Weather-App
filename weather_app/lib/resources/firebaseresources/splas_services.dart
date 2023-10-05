import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SpalshServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, 'home_screen');
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, 'login_screen');
      });
    }
  }
}
