import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/entity/location.dart';
import 'package:flutter_weather/domain/entity/weather.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_current_weather.dart';
import 'package:flutter_weather/main.dart';
import 'package:logger/logger.dart';

class WeatherViewModel extends ChangeNotifier {
  final GetCurrentWeather getCurrentWeather;
  final GetCurrentLocation getCurrentLocation;

  (Weather, Location)? _weather;
  (Weather, Location)? get weather => _weather;

  WeatherViewModel()
      : getCurrentWeather = getIt.get<GetCurrentWeather>(),
        getCurrentLocation = getIt.get<GetCurrentLocation>();

  Future<void> fetchWeatherWithLocation() async {
    final position = await getCurrentLocation.getCurrentLocation();
    _weather = await getCurrentWeather.getCurrentLocationWeather(position);
    Logger().i("FETCH | Weather now : ${weather?.$2.localtimeEpoch}");
    notifyListeners();
  }
}
