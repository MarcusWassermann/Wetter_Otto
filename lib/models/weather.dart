class Weather {
  final String time;
  final double temperature;
  final double apparentTemperature;
  final int isDay;
  final double precipitation;

  Weather({
    required this.time,
    required this.temperature,
    required this.apparentTemperature,
    required this.isDay,
    required this.precipitation,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      time: json['time'],
      temperature: json['temperature_2m'],
      apparentTemperature: json['apparent_temperature'],
      isDay: json['is_day'],
      precipitation: json['precipitation'],
    );
  }
}
