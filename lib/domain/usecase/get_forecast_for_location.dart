import 'package:flutter_weather/data/repository/weather_repository_impl.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:geolocator/geolocator.dart';

class GetForecastForLocation {
  final repository = WeatherRepositoryImpl();

  Future<WeatherData>? getForecastForLocation(Position location, int days) {
    return repository.getForecastForLocation(location, days);
  }
}
