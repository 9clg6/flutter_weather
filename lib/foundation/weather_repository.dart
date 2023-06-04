import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

abstract class WeatherRepository {
  Future<WeatherData>? getForecastByLocation(
    Position? location,
    String? city,
    int days,
    Client? client,
  );
  Future<WeatherData>? getForecastByCityAndDate(
    String city,
    DateTime date,
    Client? client,
  );
}
