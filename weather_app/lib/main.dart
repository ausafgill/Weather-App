import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/routes/routes.dart';
import 'package:weather_app/utils/routes/routes_names.dart';
import 'package:weather_app/viewmodel/themeview/themechanger.dart';
import 'package:weather_app/viewmodel/weather_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => WeatherView()),
          ChangeNotifierProvider(create: (_) => ThemeChanger())
        ],
        child: Builder(builder: (BuildContext context) {
          return MaterialApp(
            title: 'Weather App',
            debugShowCheckedModeBanner: false,
            initialRoute: RoutesNames.splashScreen,
            onGenerateRoute: Routes.generateRoute,
            themeMode: Provider.of<ThemeChanger>(context).currentTheme,
            theme: ThemeData(
                brightness: Brightness.light,
                textTheme: TextTheme(
                  titleLarge: GoogleFonts.ubuntu(
                      color: Colors.black54,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                  bodySmall: GoogleFonts.ubuntu(
                      color: Colors.black54,
                      fontSize: 16,
                      decoration: TextDecoration.none),
                  bodyLarge: GoogleFonts.ubuntu(
                      color: Colors.black54,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                  titleMedium: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                  displayLarge: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                  headlineMedium: GoogleFonts.ubuntu(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                )),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                textTheme: TextTheme(
                  titleLarge: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                  bodySmall: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  titleMedium: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                  displayLarge: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                  bodyLarge: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                  headlineMedium: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )),
          );
        }));
  }
}
