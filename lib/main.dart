import 'package:flutter/material.dart';
import 'AnimationViewDemo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter animation demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Animation demo'),
          ),
          body: AnimationViewDemo(),
        ));
  }
}




