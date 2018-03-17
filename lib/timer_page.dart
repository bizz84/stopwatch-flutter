import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  Stopwatch stopwatch = new Stopwatch();
  Timer timer;

  void leftButtonPressed() {
    setState(() {
      if (stopwatch.isRunning) {
        print("${stopwatch.elapsedMilliseconds}");
      } else {
        stopwatch.reset();
      }
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (stopwatch.isRunning) {
        stopwatch.stop();
        timer.cancel();
        timer = null;
      } else {
        if (timer == null) {
          timer = new Timer.periodic(new Duration(milliseconds: 30), callback);
        }
        stopwatch.start();
      }
    });
  }

  void callback(Timer timer) {
    setState(() {

    });
  }

  Widget buildFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle = const TextStyle(fontSize: 16.0, color: Colors.white);
    return new FloatingActionButton(
      child: new Text(text, style: roundTextStyle),
      onPressed: callback);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(height: 200.0, 
          child: new Center(
            child: new TimerText(milliseconds: stopwatch.elapsedMilliseconds),
        )),
        new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildFloatingButton(stopwatch.isRunning ? "lap" : "reset", leftButtonPressed),
            buildFloatingButton(stopwatch.isRunning ? "stop" : "start", rightButtonPressed),
        ]),
      ],
    );
  }
}

class TimerText extends StatelessWidget {
  TimerText({this.milliseconds});
  final int milliseconds;

  @override
  Widget build(BuildContext context) {
    final TextStyle timerTextStyle = const TextStyle(fontSize: 60.0, fontFamily: "Open Sans");
    String formattedTime = TimerTextFormatter.format(milliseconds);
    return new Text(formattedTime, style: timerTextStyle);
  }
}

class TimerTextFormatter {
  static String format(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr.$hundredsStr"; 
  }
}
