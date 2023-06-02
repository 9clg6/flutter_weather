import 'package:flutter_weather/domain/entity/weather.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherRemoteDataSource {
  Future<Weather> getCurrentWeather(String city);
  Future<Weather> getCurrentLocationWeather(Position location);
  Future<List<Weather>> getWeatherForecast(String city);
}
