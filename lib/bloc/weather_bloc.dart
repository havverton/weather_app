import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/WeatherModel.dart';
import 'package:weather/bloc/weather_events_bloc.dart';
import 'package:weather/bloc/weather_states_bloc.dart';
import 'package:weather/const/images_const.dart';
import 'package:weather/network/WeatherCityModel.dart';
import 'package:weather/network/WeatherRepository.dart';

class CurrentWeatherBLoC extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  CurrentWeatherBLoC(this.weatherRepository) : super(WeatherNotLoadState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    CityWeather _loadedWeather;
    List<CityWeather> weatherList = [];
    Image _loadedImg;

    try {
      if (event is CurrentWeatherListEvent) {
        yield WeatherLoadingState();
         await WeatherRepository().fetchLocationList();
         yield WeatherLoadedListState();
         print("kekw");


      }
      if (event is CurrentWeatherLoadEvent) {
        final weather = (locations[event.index]);
          final Image img;
          switch (weather.weather.first.main) {
            case "Clear":
              img = clear_sky_image;
              break;
            case "Rain":
              img = rain_image;
              break;
            case "Snow":
              img = snow_image;
              break;
            case "Thunderstorm":
              img = thunderstorm_image;
              break;
            case "Clouds":
              if (weather.weather.first.description == "few clouds" ||
                  weather.weather.first.description == "scattered clouds") {
                img = cloudy_image;
              } else {
                img = broken_cloud_image;
              }
              break;
            default:
              img = broken_cloud_image;
              break;
          }
        locations[event.index] = weather;

        yield WeatherLoadedState(index: event.index, img: img);
      }
    } catch (_) {
      throw Exception(_);
      yield WeatherErrorState();
    }
  }
}

/*
class  CurrentWeatherImageBLoC extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  CurrentWeatherImageBLoC(this.weatherRepository) : super(WeatherNotLoadState());


  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    Image _loadedImg;
    yield WeatherLoadingListState();
    try {
      if(event is CurrentWeatherImageEvent){
        _loadedImg = Image.asset("assets/clear_sky.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity);
        switch(event.weather.main){
          case "Clear": _loadedImg = Image.asset("assets/clear_sky.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity); break;
          case "Rain": _loadedImg = Image.asset("assets/Rain.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity); break;
          case "Snow": _loadedImg = Image.asset("assets/snow.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity);break;
          case "Thunderstorm": _loadedImg = Image.asset("assets/thunderstorm.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity);break;
          case "Clouds":
            if(event.weather.description == "few clouds" || event.weather.description == "scattered clouds"){
              _loadedImg = Image.asset("assets/cloudy.jpg", fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity);
            }else{
              _loadedImg = Image.asset("assets/broken_cloud.jpg", fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity);
            }
          break;
          default: _loadedImg = Image.asset("assets/thunderstorm.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity);break;

        }

        yield WeatherLoadedImageState(loadedImg: _loadedImg, index:  event.index);



      }

    } catch (_) {
      throw Exception(_);
      yield WeatherLoadingListState();
    }
  }
}*/
