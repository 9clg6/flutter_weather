import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/entity/forecast.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_forecast_for_location.dart';
import 'package:flutter_weather/main.dart';
import 'package:logger/logger.dart';

class ForecastViewModel extends ChangeNotifier {
  final GetForecastForLocation getForecastForLocation;
  final GetCurrentLocation getCurrentLocation;

  List<Forecast>? _forecastList;
  List<Forecast>? get forecastList => _forecastList;

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
    Logger().i("FETCH | Forecast for $days days: ${_forecastList?.length}");
    notifyListeners();
  }
}
