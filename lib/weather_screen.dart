import 'package:flutter/material.dart';

import 'city_weather_body.dart';

class CityWeatherScreen extends StatelessWidget {
  const CityWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Hintergrund-Gradient
      body: CityWeatherBody(),
    );
  }
}
