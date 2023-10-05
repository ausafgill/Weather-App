import 'package:flutter/material.dart';
import 'package:weather_app/utils/routes/routes_names.dart';
import 'package:weather_app/views/home_screen.dart';
import 'package:weather_app/views/login_screen.dart';
import 'package:weather_app/views/signup_screen.dart';
import 'package:weather_app/views/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case RoutesNames.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case RoutesNames.signupScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());

      case RoutesNames.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('No Route Defined'),
                  ),
                ));
    }
  }
}
