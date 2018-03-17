import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final TimerTextState _timerTextState = new TimerTextState();
  Stopwatch stopwatch = new Stopwatch();
  Timer timer;

  void leftButtonPressed() {
    setState(() {
      if (stopwatch.isRunning) {
        print("${stopwatch.elapsedMilliseconds}");
      } else {
        stopwatch.reset();
        _timerTextState.milliseconds = 0;
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
          timer = new Timer.periodic(new Duration(milliseconds: 10), callback);
        }
        stopwatch.start();
      }
    });
  }

  void callback(Timer timer) {
    setState(() {
      _timerTextState.milliseconds = stopwatch.elapsedMilliseconds;
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
            child: _timerTextState.build(context),
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

class TimerText extends StatefulWidget {

  TimerTextState createState() => new TimerTextState();
}

class TimerTextState extends State<TimerText> {

  TextStyle timerTextStyle = const TextStyle(fontSize: 60.0, fontFamily: "Open Sans");
  int milliseconds = 0;

  @override
  Widget build(BuildContext context) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    return new Text("$minutesStr:$secondsStr.$hundredsStr", style: timerTextStyle);
  }
}
