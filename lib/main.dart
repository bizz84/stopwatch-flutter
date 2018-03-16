import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {}
  //_MyHomePageState({Key key, this.title}) : super(key: key);
  //final String title;
  final List<ListItem> _items = <ListItem>[];

  void leftButtonPressed() {

  }

  void rightButtonPressed() {

  }

  Widget buildFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle = const TextStyle(fontSize: 16.0, color: Colors.white);
    return new FloatingActionButton(
      child: new Text(text, style: roundTextStyle),
      onPressed: callback);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle timerTextStyle = const TextStyle(fontSize: 60.0);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(height: 200.0, 
              child: new Center(
                child: new Text("00:00:00", style: timerTextStyle),
            )),
            new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildFloatingButton("reset", leftButtonPressed),
                buildFloatingButton("start", rightButtonPressed),
            ]),
            new ListView.builder(padding: new EdgeInsets.all(8.0),
                  reverse: false,
                  itemBuilder: (_, int index) => _items[index],
                  itemCount: _items.length),
          ],
        )
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Container(
      child: new Text("test")                                    //modified
    );
  }
}