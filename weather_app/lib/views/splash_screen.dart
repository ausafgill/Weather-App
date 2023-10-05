import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/resources/firebaseresources/splas_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SpalshServices splashScreen = SpalshServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/UIHeaderDesign.png'),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(vertical: 50),
            child: Image.asset(
              'assets/images/logo.png',
              height: 150,
            ),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('assets/images/UIFooterDesign.png'))),
        ],
      ),
    );
  }
}
