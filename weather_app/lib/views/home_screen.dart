import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weathermodel.dart';
import 'package:weather_app/resources/apiurl.dart';
import 'package:weather_app/resources/consts/images.dart';

import 'package:weather_app/utils/routes/utils.dart';
import 'package:weather_app/viewmodel/themeview/themechanger.dart';

import 'package:weather_app/viewmodel/weather_view.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController cityName = TextEditingController();
  WeatherModel? weatherData = null;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<WeatherView>(context);
    var date = DateFormat('yMMMd').format(DateTime.now());
    final themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          date,
          style: Theme.of(context).copyWith().textTheme.titleMedium,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                final newTheme = themeChanger.currentTheme == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
                themeChanger.setTheme(newTheme);
              },
              icon: Icon(
                Icons.light_mode,
                color: themeChanger.currentTheme == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              )),
          InkWell(
              onTap: () {
                _auth.signOut().then((value) {
                  Navigator.pushNamed(context, 'login_screen');
                }).onError((error, stackTrace) {
                  Utils().showErrorFlushBar(
                      error.toString(), context, Icon(Icons.error), Colors.red);
                });
              },
              child: Icon(
                Icons.logout,
                color: themeChanger.currentTheme == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: TextFormField(
                style: Theme.of(context).copyWith().textTheme.bodySmall,
                controller: cityName,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  border: InputBorder.none,
                  hintText: 'CityName',
                  hintStyle: Theme.of(context).copyWith().textTheme.bodySmall,
                  suffixIcon: InkWell(
                      onTap: () {
                        String enteredCityName = cityName.text.toString();
                        if (enteredCityName.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                            weatherData = null;
                          });
                          authProvider
                              .getWeatherApiData(enteredCityName)
                              .then((data) {
                            print('Response : $data');
                            setState(() {
                              weatherData = data;
                              isLoading = false;
                            });
                          }).onError((error, stackTrace) {
                            print(error.toString());
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      },
                      child: Icon(Icons.search)),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: themeChanger.currentTheme == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                  ))
                : weatherData != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weatherData!.location.name.toUpperCase(),
                                style: Theme.of(context)
                                    .copyWith()
                                    .textTheme
                                    .displayLarge,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    getimgCurrent(),
                                    height: 80,
                                    width: 80,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: weatherData!.current.tempC
                                            .toString(),
                                        style: Theme.of(context)
                                            .copyWith()
                                            .textTheme
                                            .bodyLarge),
                                    TextSpan(
                                        text:
                                            weatherData!.current.condition.text,
                                        style: Theme.of(context)
                                            .copyWith()
                                            .textTheme
                                            .bodySmall)
                                  ]))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                      onPressed: null,
                                      icon: Icon(Icons.expand_more),
                                      label: Text(weatherData!
                                          .forecast.forecastday[0].day.mintempC
                                          .toString())),
                                  TextButton.icon(
                                      onPressed: null,
                                      icon: Icon(Icons.expand_less),
                                      label: Text(weatherData!
                                          .forecast.forecastday[0].day.maxtempC
                                          .toString())),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(3, (index) {
                                    var iconList = [
                                      clouds,
                                      humidity,
                                      windspeed
                                    ];
                                    var values = [
                                      '${weatherData!.forecast.forecastday[0].hour[0].cloud.toString()}%',
                                      '${weatherData!.forecast.forecastday[0].hour[0].humidity.toString()}%',
                                      '${weatherData!.forecast.forecastday[0].hour[0].windKph.toString()}KM/Hr',
                                    ];
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Image.asset(
                                            iconList[index],
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          values[index].toString(),
                                          style: Theme.of(context)
                                              .copyWith()
                                              .textTheme
                                              .bodySmall,
                                        )
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              const Divider(),
                              SizedBox(
                                height: 170,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: weatherData!
                                        .forecast.forecastday.length,
                                    itemBuilder: (context, index) {
                                      var hrDate = DateFormat().add_jm().format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                weatherData!
                                                        .forecast
                                                        .forecastday[0]
                                                        .hour[index]
                                                        .timeEpoch *
                                                    1000),
                                          );
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(15),
                                        height: 60,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade400,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          children: [
                                            Text(
                                              hrDate,
                                              style: Theme.of(context)
                                                  .copyWith()
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Image.asset(
                                              getimghr(index),
                                            ),
                                            Text(
                                                '${weatherData!.forecast.forecastday[index].hour[index].tempC.toString()}°',
                                                style: GoogleFonts.ubuntu(
                                                    color: Colors.white,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Next 3 Days',
                                    style: Theme.of(context)
                                        .copyWith()
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  Text(
                                    'View All',
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.blue, fontSize: 15),
                                  )
                                ],
                              ),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    var day = DateFormat('EEEE', 'en_US')
                                        .format(DateTime.now()
                                            .add(Duration(days: index + 1)));
                                    return Card(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                day.toString(),
                                                style: Theme.of(context)
                                                    .copyWith()
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton.icon(
                                                  onPressed: null,
                                                  icon: Image.asset(
                                                    getimgDay(index),
                                                    width: 40,
                                                  ),
                                                  label: Text(
                                                      '${weatherData!.forecast.forecastday[index].day.avgtempC.toString()}°')),
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text:
                                                    '${weatherData!.forecast.forecastday[index].day.maxtempC}°',
                                                style: Theme.of(context)
                                                    .copyWith()
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                              TextSpan(
                                                text:
                                                    '/${weatherData!.forecast.forecastday[index].day.mintempC}°',
                                                style: Theme.of(context)
                                                    .copyWith()
                                                    .textTheme
                                                    .headlineMedium,
                                              )
                                            ]))
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      )
                    : weatherData == null && cityName.text.isNotEmpty
                        ? Text('No data found')
                        : SizedBox(),
          ),
        ],
      ),
    );
  }

  String getimghr(int index) {
    String currentWeather = weatherData!
        .forecast.forecastday[0].hour[index].condition.text
        .toString();
    debugPrint('HR:${currentWeather}');

    if (currentWeather == 'Clear' ||
        currentWeather == 'Partly cloudy' ||
        currentWeather == 'Sunny') {
      return 'assets/weatherimages/sunny.png';
    } else if (currentWeather == 'Freezing fog' ||
        currentWeather == 'Fog' ||
        currentWeather == 'Heavy cloud' ||
        currentWeather == 'Overcast' ||
        currentWeather == 'Cloudy') {
      return 'assets/weatherimages/cloudy.png';
    } else if (currentWeather == 'Patchy rain possible' ||
        currentWeather == 'Heavy Rain' ||
        currentWeather == 'Showers' ||
        currentWeather == 'Light rain' ||
        currentWeather == 'Moderate rain') {
      return 'assets/weatherimages/rainy.png';
    } else {
      return 'assets/weatherimages/sunny.png';
    }
  }

  String getimgCurrent() {
    String currentWeather = weatherData!.current.condition.text.toString();
    debugPrint('Current:${currentWeather}');
    if (currentWeather == 'Clear' ||
        currentWeather == 'Partly cloudy' ||
        currentWeather == 'Sunny') {
      return 'assets/weatherimages/sunny.png';
    } else if (currentWeather == 'Freezing fog' ||
        currentWeather == 'Fog' ||
        currentWeather == 'Heavy cloud' ||
        currentWeather == 'Overcast' ||
        currentWeather == 'Cloudy') {
      return 'assets/weatherimages/cloudy.png';
    } else if (currentWeather == 'Patchy rain possible' ||
        currentWeather == 'Heavy Rain' ||
        currentWeather == 'Showers' ||
        currentWeather == 'Light rain' ||
        currentWeather == 'Moderate rain') {
      return 'assets/weatherimages/rainy.png';
    } else {
      return 'assets/weatherimages/sunny.png';
    }
  }

  String getimgDay(int index) {
    String currentWeather =
        weatherData!.forecast.forecastday[index].day.condition.text.toString();
    debugPrint('Day:${currentWeather}');
    if (currentWeather == 'Clear' ||
        currentWeather == 'Partly cloudy' ||
        currentWeather == 'Sunny') {
      return 'assets/weatherimages/sunny.png';
    } else if (currentWeather == 'Freezing fog' ||
        currentWeather == 'Fog' ||
        currentWeather == 'Heavy cloud' ||
        currentWeather == 'Overcast' ||
        currentWeather == 'Cloudy') {
      return 'assets/weatherimages/cloudy.png';
    } else if (currentWeather == 'Patchy rain possible' ||
        currentWeather == 'Heavy Rain' ||
        currentWeather == 'Showers' ||
        currentWeather == 'Light rain' ||
        currentWeather == 'Moderate rain') {
      return 'assets/weatherimages/rainy.png';
    } else {
      return 'assets/weatherimages/sunny.png';
    }
  }
}
