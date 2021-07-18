import 'package:flutter/material.dart';
import 'package:weather/network/WeatherCityModel.dart';

abstract class WeatherState {}

class WeatherNotLoadState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}
class WeatherLoadedListState extends WeatherState {}


class WeatherLoadedState extends WeatherState {
  int index;
  Image img;
  WeatherLoadedState({required this.index, required this.img});
}

class WeatherErrorState extends WeatherState {

}