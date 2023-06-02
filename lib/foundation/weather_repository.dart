import 'package:flutter_weather/domain/entity/weather.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentCityWeather(String city);
  Future<List<Weather>> getWeatherForecast(String city);
  Future<Weather>? getCurrentLocationWeather(Position location);
}
