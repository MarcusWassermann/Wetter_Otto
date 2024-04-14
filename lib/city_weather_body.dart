import 'package:flutter/material.dart';

import 'package:wetter_otto/repositorys/geo_repository.dart';
import 'package:wetter_otto/repositorys/weather_repository.dart';

class CityWeatherBody extends StatefulWidget {
  const CityWeatherBody({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CityWeatherBodyState createState() => _CityWeatherBodyState();
}

class _CityWeatherBodyState extends State<CityWeatherBody> {
  final GeocodingRepository _geocodingRepository =
      GeocodingRepository("GfNIp6+CGKe15sBApfhuzw==Lq6WssiQvwAhzacW");
  final WeatherRepository _weatherRepository = WeatherRepository();
  String cityName = '';
  double latitude = 0.0;
  double longitude = 0.0;
  String time = "";
  double temperature = 0.0;
  double apparentTemperature = 0.0;
  int isDay = 0;
  double precipitation = 0.0;
  bool isLoading = false;

  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final city = await _geocodingRepository.fetchCityCoordinates(cityName);
      setState(() {
        latitude = city.latitude;
        longitude = city.longitude;
        _cityController.clear();
      });

      final weather =
          await _weatherRepository.fetchWeather(latitude, longitude);
      setState(() {
        time = weather.time;
        temperature = weather.temperature;
        apparentTemperature = weather.apparentTemperature;
        isDay = weather.isDay;
        precipitation = weather.precipitation;
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching data: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(230, 211, 234, 184),
            Colors.lightBlueAccent,
            Colors.lightGreenAccent,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: _cityController,
                onChanged: (value) {
                  cityName = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                  border: InputBorder.none,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : fetchData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Get City Info & Weather'),
            ),
            const SizedBox(height: 20),
            Text(
              'City: $cityName',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Latitude: $latitude',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Longitude: $longitude',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Time: $time',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Temperature: $temperature °C',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Apparent Temperature: $apparentTemperature °C',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Day time: ${isDay == 1 ? "Day" : "Night"}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Precipitation: $precipitation mm',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
