import 'package:flutter/material.dart';
import 'AnimationViewDemo.dart';
import 'CustomCheckView.dart';
import 'CustomViewDemo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter animation demo',
        home: new MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Center(
          child: RawMaterialButton(
              child: Text('tap'),
              onPressed: () {
                FinishAnimation.show(context);
              })),
    );
  }
}



