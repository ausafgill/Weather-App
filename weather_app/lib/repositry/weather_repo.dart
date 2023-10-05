import 'package:weather_app/data/network/baseapiservices.dart';
import 'package:weather_app/data/network/networkapiservices.dart';

import 'package:weather_app/models/weathermodel.dart';
import 'package:weather_app/resources/apiurl.dart';

class WeatherRespositry {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<dynamic> hitWeatherApi(String cityname) async {
    try {
      dynamic response = await _apiServices
          .getWeatherApiResponses('${ApiUrl.weatherUrl}q=$cityname&days=7');
      // print(response);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }
}
// Map<String, dynamic> data = response;
      // final WeatherModel weatherModel = WeatherModel.fromJson(data);
// q=$cityname&days=7