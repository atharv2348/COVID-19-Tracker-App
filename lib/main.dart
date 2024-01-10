import 'package:covid_19_tracker_app/View/countries_states.dart';
import 'package:covid_19_tracker_app/View/splash_screen.dart';
import 'package:covid_19_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}