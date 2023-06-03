import 'dart:convert';

import 'package:flutter_weather/data/constants.dart';
import 'package:flutter_weather/data/util/api_helper.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/foundation/weather_remote_datasource.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<WeatherData>? getForecastForLocation(Position location, int days) async {
    final currentLocationWeatherResponse = await ApiHelper.get(
      url: forecastApiBase,
      params: {
        "key": apiKey,
        "days": days,
        "alerts": "no",
        "aqi": "no",
        "q": "${location.latitude},${location.longitude}",
      },
    );
    final decodedWeather = jsonDecode(currentLocationWeatherResponse.body);
    return WeatherData.fromJson(decodedWeather);
  }
}
