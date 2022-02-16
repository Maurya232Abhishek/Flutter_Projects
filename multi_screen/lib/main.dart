import 'package:flutter/material.dart';
import 'firstScreen.dart';
import 'secondscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => firstscreen(),
      '/second': (context) => secscreen(),
    },
  ));
}

