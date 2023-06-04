import 'package:flutter_weather/data/repository/weather_repository_impl.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class GetForecastByLocation {
  final repository = WeatherRepositoryImpl();

  Future<WeatherData>? getForecastByLocation({
    Position? location,
    String? city,
    int days = 1,
    Client? client,
  }) {
    return repository.getForecastByLocation(location, city, days, client);
  }
}
