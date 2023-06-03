import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_forecast_for_location.dart';
import 'package:flutter_weather/main.dart';
import 'package:logger/logger.dart';

class ForecastViewModel extends ChangeNotifier {
  final GetForecastForLocation getForecastForLocation;
  final GetCurrentLocation getCurrentLocation;

  WeatherData? _forecastList;
  WeatherData? get weatherData => _forecastList;

  ForecastViewModel()
      : getForecastForLocation = getIt.get<GetForecastForLocation>(),
        getCurrentLocation = getIt.get<GetCurrentLocation>();

  Future<void> fetchForecast({String? cityName, int days = 1}) async {
    if (cityName == null) {
      final position = await getCurrentLocation.getCurrentLocation();
      _forecastList = await getForecastForLocation.getForecastForLocation(position, days);
    } else {
      //_forecastList = await getForecastForLocation.getForecastForLocation(position, days);
    }
    Logger().i("FETCH | Forecast for $days days: ${_forecastList?.forecast.length}");
    notifyListeners();
  }
}
