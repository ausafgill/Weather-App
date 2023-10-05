import 'dart:convert';
import 'dart:io';

import 'package:weather_app/data/exceptions.dart';
import 'package:weather_app/data/network/baseapiservices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getWeatherApiResponses(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('NO INTERNET');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 404:
        throw BadRequestException('BAD REQUEST ERROR 404');
      default:
        throw FetchDataException(
            'Error with STATUS CODE ${response.statusCode}');
    }
  }
}
