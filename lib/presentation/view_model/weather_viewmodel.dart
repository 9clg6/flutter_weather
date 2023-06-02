import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/entity/weather.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_current_weather.dart';
import 'package:geolocator/geolocator.dart';

class WeatherViewModel extends ChangeNotifier {
  final GetCurrentWeather getCurrentWeather;
  final GetCurrentLocation getCurrentLocation;
  Weather? _weather;
  String? _error;

  WeatherViewModel(this.getCurrentWeather, this.getCurrentLocation);

  Weather? get weather => _weather;

  Future<void> fetchWeatherWithLocation() async {
    Position position = await getCurrentLocation.getCurrentLocation();
    _weather = await getCurrentWeather.getCurrentLocationWeather(position);
    notifyListeners();
  }
}
