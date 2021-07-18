import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:weather/WeatherModel.dart';

class SunStatusWidget extends StatefulWidget {
  final int index;

  const SunStatusWidget(this.index,{Key? key}) : super( key: key);

  @override
  _SunStatusWidgetState createState() => _SunStatusWidgetState();
}

class _SunStatusWidgetState extends State<SunStatusWidget> {

  @override
  Widget build(BuildContext context) {

    final sunrise = DateTime.fromMillisecondsSinceEpoch((locations[widget.index].sys.sunrise)*1000).toUtc().add(Duration(seconds: locations[widget.index].timezone));
    final sunset = DateTime.fromMillisecondsSinceEpoch(locations[widget.index].sys.sunset*1000).toUtc().add(Duration(seconds: locations[widget.index].timezone));
    final datetime = DateTime.now().toUtc().add(Duration(seconds: locations[widget.index].timezone));
    final percent = getPercentOfDay(sunrise,sunset,datetime);
    return Column(
      children: [
        Container(
          width: 370,
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ClipRect(
            child: CustomPaint(
              painter: SunshinePainter(percent),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sunrise ${getTime(sunrise)}"),
              Text("Sunset ${getTime(sunset)}"),
            ],
          ),
        )
      ],
    );
  }
  String getTime(DateTime date){
    var hour;
    var minutes;
    if(date.hour < 10){
      hour = "0${date.hour}";}
    else hour = date.hour.toString();
    if(date.minute < 10){
      minutes = "0${date.minute}";}
    else minutes = date.minute.toString();
    return "$hour:$minutes";
  }

  double getPercentOfDay(DateTime sunrise, DateTime sunset, DateTime datetime){
    var end = sunset.millisecondsSinceEpoch - sunrise.millisecondsSinceEpoch;
    var now = datetime.millisecondsSinceEpoch - sunrise.millisecondsSinceEpoch;
    var percent = now/(end/100)/100;
    return percent;
  }

}

class SunshinePainter extends CustomPainter {
  var percent;

  SunshinePainter(double this.percent);

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
    return false;
  }
}
