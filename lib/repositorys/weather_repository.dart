import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';

class WeatherRepository {
  Future<Weather> fetchWeather(double latitude, double longitude) async {
    try {
      final apiUrl =
          'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,apparent_temperature,is_day,precipitation&timezone=Europe%2FBerlin&forecast_days=1';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['current'];
        return Weather.fromJson(decodedData);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      throw Exception('Error fetching weather data: $error');
    }
  }
}

