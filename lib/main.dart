import 'package:flutter/material.dart';
import 'package:wetter_otto/weather_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Info & Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CityWeatherScreen(),
    );
  }
}
