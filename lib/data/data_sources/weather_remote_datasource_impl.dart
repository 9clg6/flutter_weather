import 'dart:convert';

import 'package:flutter_weather/data/constants.dart';
import 'package:flutter_weather/data/util/api_helper.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/domain/exception/no_location_found_exception.dart';
import 'package:flutter_weather/foundation/weather_remote_datasource.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<WeatherData>? getForecastForLocation(Position? location, String? city, int days) async {
    final currentLocationWeatherResponse = await ApiHelper.get(
      url: forecastApiBase,
      params: {
        "key": apiKey,
        "days": days,
        "alerts": "no",
        "aqi": "no",
        "q": location != null ? "${location.latitude},${location.longitude}" : city,
        "lang": "fr",
      },
    );
    final decodedWeather = jsonDecode(currentLocationWeatherResponse.body);
    if (city != null && decodedWeather["error"] != null) {
      throw NoLocationFoundException("Aucune ville n'a été trouvée avec ce nom");
    }
    return WeatherData.fromJson(decodedWeather);
  }
}
