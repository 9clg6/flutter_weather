import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherData>? getForecastForLocation(Position location, int days);
}
