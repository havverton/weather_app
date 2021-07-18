import 'package:flutter/material.dart';
import 'package:weather/WeatherModel.dart';

import 'SunStatusAnimWidget.dart';

class SingleWeatherWidget extends StatefulWidget {

  final int index;

  const SingleWeatherWidget(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  _SingleWeatherWidgetState createState() => _SingleWeatherWidgetState();
}

class _SingleWeatherWidgetState extends State<SingleWeatherWidget> {
  final mainColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Flex(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.vertical,
        children: [
          SizedBox(
            height: 120,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              height: 300,
              color: mainColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${locations[widget.index].name}",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      Text(
                        getCurrentDate(locations[widget.index].dt),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${(locations[widget.index].main.temp).round()}",
                            style: TextStyle(color: Colors.white, fontSize: 70),
                          ),
                          Text(
                            "о",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            "C",
                            style: TextStyle(color: Colors.white, fontSize: 70),
                          ),
                        ],
                      ), Row(
                              children: [
                                /*Icon(Icons.nightlight_round,
                                    color: Colors.white),*/
                                Text(
                                  "${locations[widget.index].weather.first.main}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            )

                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xAAFFFFFF)),
              child: Column(children: [
                SunStatusWidget(widget.index),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Temperature"),
                            leading: Icon(Icons.thermostat_outlined),
                            subtitle: Text("${(locations[widget.index].main.feels_like).round()} C"),
                          ),
                          ListTile(
                            title: Text("Wheather"),
                            leading: Icon(Icons.cloud),
                            subtitle: Text("${locations[widget.index].weather.first.description}"),
                          ),
                          ListTile(
                            title: Text("Humidity"),
                            leading: Icon(Icons.water_sharp),
                            subtitle: Text("${locations[widget.index].main.humidity}%"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text("Wind Speed"),
                            leading: Icon(Icons.arrow_right_alt_outlined),
                            subtitle: Text("${locations[widget.index].wind.speed} m/s"),
                          ),
                          ListTile(
                            title: Text("Pressure"),
                            leading: Icon(Icons.arrow_downward),
                            subtitle: Text("${locations[widget.index].main.pressure} hPa"),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  String getCurrentDate(int datetime) {
    final date = DateTime.now().toUtc().add(Duration(seconds: locations[widget.index].timezone));
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    var hour;
    var minutes;
    if(date.hour < 10){
      hour = "0${date.hour}";}
    else hour = date.hour.toString();
    if(date.minute < 10){
      minutes = "0${date.minute}";}
    else minutes = date.minute.toString();

    return "$hour:$minutes - ${days[date.weekday-1]}, ${date.day} ${months[date.month - 1]} ${date.year}";
  }

  bool isNight(int sunrise, int sunset, int date) {
    if (date >= sunrise && date <= sunset) return false;
    return true;
  }
}
