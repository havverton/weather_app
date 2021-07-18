import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/WeatherModel.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/bloc/weather_events_bloc.dart';
import 'package:weather/bloc/weather_states_bloc.dart';
import 'package:weather/network/WeatherRepository.dart';
import 'package:weather/widgets/SingleWeatherWidget.dart';
import 'package:weather/widgets/slider_dot.dart';

import 'const/images_const.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final mainColor = Colors.lightBlue;
  var _currentPage = 0;
  bool isTimerOn = false;
  Image bgImg = rain_image;
  WeatherRepository weatherRepository = WeatherRepository();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PageController _pageController = PageController(initialPage: 0);


  @override
  void didChangeDependencies() {
    precacheImage(bgImg.image, context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {
              setState() {}
            },
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [IconButton(onPressed: () => {}, icon: Icon(Icons.menu))],
        ),
        body: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => CurrentWeatherBLoC(weatherRepository)),
            ],
            child: Builder(
              builder: (providerContext) {
                CurrentWeatherBLoC weatherBLoC =
                    BlocProvider.of<CurrentWeatherBLoC>(providerContext);

                // weatherBLoC.add(CurrentWeatherListEvent());
                return Stack(children: [
                  BlocBuilder<CurrentWeatherBLoC, WeatherState>(
                      builder: (context, state) {
                          return AnimatedSwitcher(
                            //opacity:  _animation,
                            duration: Duration(seconds: 2),
                            child: bgImg,
                          );
                        }
                      ),
                      Container(
                          decoration: BoxDecoration(color: Colors.black12)),
                  BlocBuilder<CurrentWeatherBLoC, WeatherState>(
                      builder: (context, state) {
                          return Container(
                            margin: EdgeInsets.only(top: 100, left: 5),
                            child: Row(
                              children: [
                                for (int i = 0; i < cities.length; i++)
                                  if (i == _currentPage)
                                    SliderDot(true)
                                  else
                                    SliderDot(false)
                              ],
                            ),
                          );
                        }
                      ),
                      BlocBuilder<CurrentWeatherBLoC, WeatherState>(
                          builder: (context, state) {
                        if (state is WeatherNotLoadState) {
                          if (locations.isEmpty) {
                            weatherBLoC.add(CurrentWeatherListEvent());
                            return Center(child: Text("Чето пока пусто"));
                          }
                        } else if (state is WeatherLoadedListState) {
                          weatherBLoC.add(CurrentWeatherLoadEvent(index: 0));
                        } else if (state is WeatherLoadedState) {
                          _currentPage = state.index;
                          bgImg = state.img;
                          return Container(
                            child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: cities.length,
                                controller: _pageController,
                                onPageChanged: (i) {
                                  weatherBLoC
                                      .add(CurrentWeatherLoadEvent(index: i));
                                },
                                itemBuilder: (context, i) {
                                  //  i = _currentPage;
                                  if (locations.isNotEmpty) {
                                    return SingleWeatherWidget(i);
                                  } else {
                                    return Container();
                                  }
                                }),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      })
                    ]);
                  } )));

  }
}
