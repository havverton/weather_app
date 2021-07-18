import 'package:weather/network/WeatherCityModel.dart';

abstract class WeatherEvent{
}

class CurrentWeatherLoadEvent extends WeatherEvent{
int index;
CurrentWeatherLoadEvent({required this.index});
}
class CurrentWeatherListEvent extends WeatherEvent{

}