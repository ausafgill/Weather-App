import 'package:flutter/material.dart';
import 'package:weather_app/models/weathermodel.dart';

import 'package:weather_app/repositry/weather_repo.dart';

class WeatherView with ChangeNotifier {
  // Future<WeatherModel> getWeatherApiData(String cityName) async {
  //   dynamic data = await WeatherRespositry().hitWeatherApi(cityName);
  //   Map<String, dynamic> finalData = data;
  //   WeatherModel weatherModel = WeatherModel.fromJson(finalData);
  //   return weatherModel;
  // }

  Future<WeatherModel> getWeatherApiData(String cityName) async {
    try {
      dynamic data = await WeatherRespositry().hitWeatherApi(cityName);
      print('API Data in getWeatherApiData: $data');
      Map<String, dynamic> finalData = data;
      WeatherModel weatherModel = WeatherModel.fromJson(finalData);
      return weatherModel;
    } catch (e) {
      print('API Error in getWeatherApiData: $e');
      throw e.toString();
    }
  }
}
