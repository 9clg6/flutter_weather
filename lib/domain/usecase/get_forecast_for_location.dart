import 'package:flutter_weather/data/repository/weather_repository_impl.dart';
import 'package:flutter_weather/domain/entity/forecast.dart';
import 'package:geolocator/geolocator.dart';

class GetForecastForLocation {
  final repository = WeatherRepositoryImpl();

  Future<List<Forecast>>? getForecastForLocation(Position location, int days) {
    return repository.getForecastForLocation(location, days);
  }
}
