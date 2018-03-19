import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  Stopwatch stopwatch = new Stopwatch();

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
      } else {
        stopwatch.start();
      }
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Expanded(
          child: new TimerText(stopwatch: stopwatch),
        ),
        new Expanded(
          flex: 0,
          child: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildFloatingButton(stopwatch.isRunning ? "lap" : "reset", leftButtonPressed),
                buildFloatingButton(stopwatch.isRunning ? "stop" : "start", rightButtonPressed),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({this.stopwatch});
  final Stopwatch stopwatch;

  TimerTextState createState() => new TimerTextState(stopwatch: stopwatch);
}

class TimerTextState extends State<TimerText> {

  Timer timer;
  final Stopwatch stopwatch;
  int milliseconds;

  TimerTextState({this.stopwatch});

  @override
  void initState() {
    timer = new Timer.periodic(new Duration(milliseconds: 30), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != stopwatch.elapsedMilliseconds) {
      milliseconds = stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          flex: 2,
          child: new RepaintBoundary(
            child: new SizedBox(
              height: 72.0,
              child: new MinutesAndSeconds(stopwatch),
            ),
          ),
        ),
        new Expanded(
          flex: 1,
          child: new RepaintBoundary(
            child: new SizedBox(
              height: 72.0,
              child: new Hundreds(stopwatch),
            ),
          ),
        ),
      ],
    );
  }
}

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
const TextStyle timerTextStyle = const TextStyle(fontSize: 60.0, fontFamily: "Open Sans");

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds(this.stopwatch);

  final Stopwatch stopwatch;

  MinutesAndSecondsState createState() => new MinutesAndSecondsState(stopwatch);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  final Stopwatch stopwatch;
  int minutes = 0;
  int seconds = 0;

  MinutesAndSecondsState(this.stopwatch);

  @override
  void initState() {
    timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$minutesStr:$secondsStr.', style: timerTextStyle, textAlign: TextAlign.end);
  }
}

class Hundreds extends StatefulWidget {
  Hundreds(this.stopwatch);

  final Stopwatch stopwatch;

  HundredsState createState() => new HundredsState(stopwatch);
}

class HundredsState extends State<Hundreds> {
  final Stopwatch stopwatch;
  int hundreds = 0;

  HundredsState(this.stopwatch);

  @override
  void initState() {
    timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (hundreds % 100).toString().padLeft(2, '0');
    return new Text(minutesStr, style: timerTextStyle, textAlign: TextAlign.start);
  }
}
