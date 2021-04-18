import 'package:flutter/material.dart';
import 'package:material_speed_dial/material_speed_dial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Speed Dial Demo'),
      ),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.add),
        expandedChild: Icon(Icons.share),
        backgroundColor: Colors.blue,
        expandedBackgroundColor: Colors.black,
        children: [
          SpeedDialChild(child: Icon(Icons.close),onPressed: (){},),
          SpeedDialChild(child: Icon(Icons.pending),onPressed: (){},),
        ],
        labels: [
          Text('Test'),
          Text('Another Test'),
        ],
      ),
    );
  }
}
