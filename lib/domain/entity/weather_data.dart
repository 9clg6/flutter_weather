import 'package:flutter_weather/domain/entity/forecast.dart';
import 'package:flutter_weather/domain/entity/location.dart';
import 'package:flutter_weather/domain/entity/weather.dart';

class WeatherData {
  final Location location;
  final Weather? current;
  final List<Forecast> forecast;

  WeatherData({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: Location.fromJson(json['location']),
      current:
          json['current'] != null ? Weather.fromJson(json['current']) : null,
      forecast: (json['forecast']["forecastday"] as List)
          .map((e) => Forecast.fromJson(e))
          .toList(),
    );
  }
}
