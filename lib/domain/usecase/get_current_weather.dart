import 'package:flutter_weather/data/repository/weather_repository_impl.dart';
import 'package:flutter_weather/domain/entity/location.dart';
import 'package:flutter_weather/domain/entity/weather.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentWeather {
  final repository = WeatherRepositoryImpl();

  Future<Weather> getCurrentCityWeather(String city) {
    return repository.getCurrentCityWeather(city);
  }

  Future<(Weather, Location)>? getCurrentLocationWeather(Position location) {
    return repository.getCurrentLocationWeather(location);
  }
}
