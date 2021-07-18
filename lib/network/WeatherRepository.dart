import 'package:weather/WeatherModel.dart';
import 'package:weather/network/WeatherCityModel.dart';
import 'package:weather/network/WeatherProvider.dart';

class WeatherRepository {
  WeatherProvider _weatherProvider = WeatherProvider();

  Future<CityWeather> getCurrentWeather(String cityName) => _weatherProvider.getCurrentWeather(cityName);
  Future<void> fetchLocationList() async{
    for(var city in cities){
      locations.add(await getCurrentWeather(city));
    }

  }
}
