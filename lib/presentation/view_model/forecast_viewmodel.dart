import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_forecast_for_location.dart';
import 'package:flutter_weather/main.dart';

class ForecastViewModel extends ChangeNotifier {
  final GetForecastForLocation getForecastForLocation;
  final GetCurrentLocation getCurrentLocation;

  WeatherData? _weatherData;
  WeatherData? get weatherData => _weatherData;
  set weatherData(WeatherData? value) {
    _weatherData = value;
    notifyListeners();
  }

  ForecastViewModel()
      : getForecastForLocation = getIt.get<GetForecastForLocation>(),
        getCurrentLocation = getIt.get<GetCurrentLocation>();

  Future<void> fetchForecast({String? cityName, int days = 1}) async {
    if (cityName == null) {
      final position = await getCurrentLocation.getCurrentLocation();
      _weatherData = await getForecastForLocation.getForecastForLocation(location: position, days: days);
    } else {
      _weatherData = await getForecastForLocation.getForecastForLocation(city: cityName, days: days);
    }
    notifyListeners();
  }
}
