import 'dart:convert';

import 'package:weather/Keys.dart';
import 'package:http/http.dart' as http;
import 'package:weather/WeatherModel.dart';
import 'package:weather/network/WeatherCityModel.dart';
class WeatherProvider{
  Future<CityWeather> getCurrentWeather(String cityName) async {
    final _authority = "api.openweathermap.org";
    final _path = "data/2.5/weather";
    final _params = {
      "q": cityName,
      "appid": APIkey,
      "lang": "en",
      "units": "metric"

    };
    final _uri = Uri.https(_authority, _path, _params);

    final response = await http.get(_uri);
    final body = json.decode(response.body);
    var answer = CityWeather.fromJson(body);

    return answer;
  }
}