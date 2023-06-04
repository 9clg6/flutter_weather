import 'package:flutter_weather/data/repository/weather_repository_impl.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:http/http.dart';

class GetForecastByCityAndDate {
  final repository = WeatherRepositoryImpl();

  Future<WeatherData>? getForecastByCityAndDate({
    required String city,
    required DateTime date,
    Client? client,
  }) {
    return repository.getForecastByCityAndDate(city, date, client);
  }
}
