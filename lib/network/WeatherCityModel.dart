import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'WeatherCityModel.g.dart';

@JsonSerializable()
class CityWeather {
  String name;
  final Main main;
  final List<Weather> weather;
  final Wind wind;
  final int dt;
  final Sys sys;
  final timezone;
  @JsonKey(ignore: true)
  Image? bgImg;


  CityWeather(
      {required this.name,
      required this.main,
      required this.weather,
      required this.wind,
      required this.dt,
      required this.sys,
      required this.timezone,
      this.bgImg});

  factory CityWeather.fromJson(Map<String, dynamic> json) =>
      _$CityWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CityWeatherToJson(this);
}

@JsonSerializable()
class Weather {
  final main;
  final description;

  Weather({required this.main, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Main {
  final double temp;
  final double feels_like;
  final pressure;
  final humidity;

  Main({
    required this.temp,
    required this.feels_like,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Sys {
  final int sunrise;
  final int sunset;

  Sys({required this.sunrise,required this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}
