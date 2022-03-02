import 'package:flutter/material.dart';
import 'package:quiz_mcq_tf/firstScreen.dart';
import 'package:quiz_mcq_tf/mcq.dart';
import 'tf.dart';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes:{
      '/': (context) => firstscreen(),
      '/tf': (context) => VSJApp(),
      '/mcq':(context) => QuizApp(),

    }
  ));
}