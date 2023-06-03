import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherRepository {
  Future<WeatherData>? getForecastByLocation(Position? location, String? city, int days);

  Future<WeatherData>? getForecastByCityAndDate(String city, DateTime date);
}
