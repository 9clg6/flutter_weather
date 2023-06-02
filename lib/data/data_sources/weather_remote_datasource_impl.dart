import 'dart:convert';

import 'package:flutter_weather/data/constants.dart';
import 'package:flutter_weather/data/util/api_helper.dart';
import 'package:flutter_weather/domain/entity/weather.dart';
import 'package:flutter_weather/foundation/weather_remote_datasource.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<Weather> getCurrentWeather(String city) {
    throw UnimplementedError();
  }

  @override
  Future<List<Weather>> getWeatherForecast(String city) {
    throw UnimplementedError();
  }

  @override
  Future<Weather> getCurrentLocationWeather(Position location) async {
    final currentLocationWeatherResponse = await ApiHelper.get(
      url: currentWeatherApiBase,
      params: {
        "key": apiKey,
        "q": "${location.latitude},${location.longitude}",
      },
    );
    final decodedWeather = jsonDecode(currentLocationWeatherResponse.body);
    return Weather.fromJson(decodedWeather["current"]);
  }
}
