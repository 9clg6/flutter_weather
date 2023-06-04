import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_forecast_by_city_and_date.dart';
import 'package:flutter_weather/domain/usecase/get_forecast_by_location.dart';
import 'package:flutter_weather/main.dart';

class ForecastViewModel extends ChangeNotifier {
  final GetForecastByLocation getForecastForLocation;
  final GetCurrentLocation getCurrentLocation;
  final GetForecastByCityAndDate getForecastByCityAndDate;

  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  set weatherData(WeatherData? value) {
    _weatherData = value;
    notifyListeners();
  }

  ForecastViewModel()
      : getForecastForLocation = getIt.get<GetForecastByLocation>(),
        getCurrentLocation = getIt.get<GetCurrentLocation>(),
        getForecastByCityAndDate = getIt.get<GetForecastByCityAndDate>();

  Future<void> fetchForecast({String? cityName, int days = 1}) async {
    if (cityName == null) {
      final position = await getCurrentLocation.getCurrentLocation();
      _weatherData = await getForecastForLocation.getForecastByLocation(
          location: position, days: days);
    } else {
      _weatherData = await getForecastForLocation.getForecastByLocation(
          city: cityName, days: days);
    }
    notifyListeners();
  }

  Future<void> fetchForecastByDay(
      {required String cityName, required DateTime date}) async {
    _weatherData = await getForecastByCityAndDate.getForecastByCityAndDate(
        city: cityName, date: date);
    notifyListeners();
  }
}
