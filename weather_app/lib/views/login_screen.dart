import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/resources/widgets/credentials.dart';
import 'package:weather_app/resources/widgets/logos.dart';
import 'package:weather_app/resources/widgets/separation_line.dart';
import 'package:weather_app/resources/widgets/ui_header_design.dart';
import 'package:weather_app/utils/routes/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  bool _loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  void login() {
    setState(() {
      _loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passController.text.toString())
        .then((value) {
      setState(() {
        _loading = false;
      });
      Utils().showErrorFlushBar('Logging In as ${value.user!.email.toString()}',
          context, Icon(Icons.login), Colors.green);
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, 'home_screen');
      });
    }).onError((error, stackTrace) {
      setState(() {
        _loading = false;
      });
      Utils().showErrorFlushBar(
          error.toString(), context, Icon(Icons.error), Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIHeaderDesign(),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Sign In To Continue',
                style: Theme.of(context).copyWith().textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Logos(),
            SizedBox(
              height: 20,
            ),
            SeparationLine(),
            SizedBox(
              height: 30,
            ),
            AddCredentials(
                loading: _loading,
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    login();
                  }
                },
                buttonTitle: 'SIGN IN',
                formkey: _formkey,
                emailController: emailController,
                obscureText: _obscureText,
                passController: passController),
            Image.asset('assets/images/UIFooterDesign.png')
          ],
        ),
      ),
    );
  }
}
