import 'package:flutter/material.dart';

import 'network/WeatherCityModel.dart';

List<CityWeather> locations = [];
/*List<CityWeather> locations2 = [
  CityWeather(
      name: "Huevo",
      main: Main(temp: 14, feels_like: 88, pressure: 2000, humidity: 1337),
      weather: [Weather(main: "Rain", description: "ololo")],
      wind: Wind(speed: 2.28),
      dt: 1626605808,
      sys: Sys(sunrise: 1626605208, sunset: 1626605908),
      timezone: 10800,
  bgImg: Image(image: null,)),

  CityWeather(
      name: "Kukuevo",
      main: Main(temp: 14, feels_like: 88, pressure: 2000, humidity: 1337),
      weather: [Weather(main: "Snow", description: "ololo")],
      wind: Wind(speed: 2.28),
      dt: 1626605808,
      sys: Sys(sunrise: 1626605208, sunset: 1626605908),
      timezone: 10800),
  CityWeather(
      name: "Baklanovo",
      main: Main(temp: 14, feels_like: 88, pressure: 2000, humidity: 1337),
      weather: [Weather(main: "Thunderstorm", description: "ololo")],
      wind: Wind(speed: 2.28),
      dt: 1626605808,
      sys: Sys(sunrise: 1626605208, sunset: 1626605908),
      timezone: 10800),
  CityWeather(
      name: "Jarishevo",
      main: Main(temp: 14, feels_like: 88, pressure: 2000, humidity: 1337),
      weather: [Weather(main: "Clouds", description: "few clouds")],
      wind: Wind(speed: 2.28),
      dt: 1626605808,
      sys: Sys(sunrise: 1626605208, sunset: 1626605909),
      timezone: 10800),
  CityWeather(
      name: "Fool's village",
      main: Main(temp: 14, feels_like: 88, pressure: 2000, humidity: 1337),
      weather: [Weather(main: "Clouds", description: "broken clouds")],
      wind: Wind(speed: 2.28),
      dt: 1626605808,
      sys: Sys(sunrise: 1626605202, sunset: 1626605909),
      timezone: 10800),
];*/
List<String> cities = ["Moscow", "Yaroslavl", "Samara", "Akulivik"];
