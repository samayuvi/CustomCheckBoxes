import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'CBoxesAndSlider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CBoxesAndSlider(title: 'Flutter Demo Home Page'),
    );
  }
}
