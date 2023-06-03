import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_forecast_for_location.dart';
import 'package:flutter_weather/main.dart';

class WeatherViewModel extends ChangeNotifier {
  final GetCurrentLocation getCurrentLocation;
  final GetForecastForLocation getForecastForLocation;

  WeatherData? _weather;
  WeatherData? get weather => _weather;

  WeatherViewModel()
      : getForecastForLocation = getIt.get<GetForecastForLocation>(),
        getCurrentLocation = getIt.get<GetCurrentLocation>();

  Future<void> fetchWeatherWithLocation() async {
    final position = await getCurrentLocation.getCurrentLocation();
    _weather = await getForecastForLocation.getForecastForLocation(location: position, days: 1);
    notifyListeners();
  }
}
