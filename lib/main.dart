import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:path_drawing/path_drawing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

class _MainPageState extends State<MainPage> {
  final mainColor = Colors.lightBlue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search,size: 30,),
          onPressed: () {  },
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(onPressed: ()=>{}, icon: Icon(Icons.menu))
        ],

      ),
      body: Center(
        child: Container(
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
                         Text("Moscow",style: TextStyle(color: Colors.white, fontSize: 35),),
                         Text("07:32 - Monday, 9 ноя 2021",style: TextStyle(color: Colors.white, fontSize: 15),)
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
                                "30",
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
                          ),
                          Row(
                            children: [
                              Icon(Icons.nightlight_round,color: Colors.white),
                              Text(
                                "Ночь",
                                style: TextStyle(color: Colors.white, fontSize: 20),
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
                    Column(
                      children: [
                        Container(
                          width: 370,
                          height: 70,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRect(
                            child: CustomPaint(
                              painter: SunshinePainter(),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Восход 04:32"),
                              Text("Закат 23:30"),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(

                          child: Column(
                            children: [
                              ListTile(
                                title: Text("Temperature"),
                                leading: Icon(Icons.thermostat_outlined),
                                subtitle: Text("12%"),
                              ),
                              ListTile(
                                title: Text("Wheather"),
                                leading: Icon(Icons.cloud),
                                subtitle: Text("12%"),
                              ),
                              ListTile(
                                title: Text("Humidity"),
                                leading: Icon(Icons.water_sharp),
                                subtitle: Text("12%"),
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
                                subtitle: Text("12%"),
                              ),
                              ListTile(
                                title: Text("Pressure"),
                                leading: Icon(Icons.arrow_downward),
                                subtitle: Text("12%"),
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
        ),
      ),
    );
  }
}

class SunshinePainter extends CustomPainter {
  var percent = 0.5;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.lightBlue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    var startPoint = Offset(0, size.height);
    var controlPoint1 = Offset(size.width / 4, size.height / 10);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 10);
    var endPoint = Offset(size.width, size.height);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[15.0, 10.5]),
      ),
      paint,
    );

    final sunPaint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final sunPaint1 = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Offset(-18, 23) & Size(size.width + 37, size.height + 100),
        -0.4, -2.4 * (1 - percent) + (2 * pi), false, sunPaint);
    canvas.drawArc(Offset(-18, 23) & Size(size.width + 37, size.height + 100),
        -2.4 * (1 - percent) + (2 * pi) - 0.4, 0.001, false, sunPaint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
