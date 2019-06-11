import 'package:flutter/material.dart';
import './pages/Splash.dart';

void main() {
  runApp(new MaterialApp(
    home: new Splash(),
    theme: ThemeData(
      buttonColor: Colors.blueAccent,
      accentColor: Colors.blueAccent
    ),
  ));
}
