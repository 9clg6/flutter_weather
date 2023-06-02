import 'package:flutter_weather/data/repository/weather_repository_impl.dart';
import 'package:flutter_weather/domain/entity/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class GetCurrentWeather {
  final repository = WeatherRepositoryImpl();

  Future<Weather> getCurrentCityWeather(String city) {
    return repository.getCurrentCityWeather(city);
  }

  Future<Weather>? getCurrentLocationWeather(Position location) {
    Logger().i("Get current weather");

    return repository.getCurrentLocationWeather(location);
  }
}
