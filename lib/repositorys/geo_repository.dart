import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/city.dart';

class GeocodingRepository {
  final String _apiKey;

  GeocodingRepository(this._apiKey);

  Future<City> fetchCityCoordinates(String cityName) async {
    try {
      final apiUrl = 'https://api.api-ninjas.com/v1/geocoding?city=$cityName';
      final response =
          await http.get(Uri.parse(apiUrl), headers: {"X-Api-Key": _apiKey});

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)[0];
        return City.fromJson(decodedData);
      } else {
        throw Exception('Failed to load city coordinates');
      }
    } catch (error) {
      throw Exception('Error fetching city coordinates: $error');
    }
  }
}
