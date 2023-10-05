import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/resources/widgets/credentials.dart';
import 'package:weather_app/resources/widgets/logos.dart';
import 'package:weather_app/resources/widgets/separation_line.dart';
import 'package:weather_app/resources/widgets/ui_header_design.dart';
import 'package:weather_app/utils/routes/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  bool loading = false;
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
                'New User? Get Started Now',
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
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    signup();
                  }
                },
                loading: loading,
                buttonTitle: 'SIGN UP',
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

  void signup() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pushNamed(context, 'home_screen');
    }).onError((error, stackTrace) {
      Utils().showErrorFlushBar(
          error.toString(), context, Icon(Icons.error), Colors.red);
      setState(() {
        loading = false;
      });
    });
  }
}
