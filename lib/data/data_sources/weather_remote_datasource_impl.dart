import 'dart:convert';

import 'package:flutter_weather/data/util/api_helper.dart';
import 'package:flutter_weather/domain/constants.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/domain/exception/get_forecast_by_city_and_date_exception.dart';
import 'package:flutter_weather/domain/exception/no_location_found_exception.dart';
import 'package:flutter_weather/foundation/weather_remote_datasource.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<WeatherData>? getForecastByLocation(Position? location, String? city, int days, Client? client) async {
    final currentLocationWeatherResponse = await ApiHelper.get(
      client: client,
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
    if (currentLocationWeatherResponse.statusCode != 200) {
      throw NoLocationFoundException("Aucune ville n'a été trouvée avec ce nom");
    }
    return WeatherData.fromJson(jsonDecode(currentLocationWeatherResponse.body));
  }

  Future<WeatherData>? getForecastByCityAndDate(String city, DateTime date, Client? client) async {
    final forecastByCityAndNameResponse = await ApiHelper.get(
      client: client,
      url: forecastApiBase,
      params: {
        "key": apiKey,
        "alerts": "no",
        "aqi": "no",
        "q": city,
        "dt": "${date.year}/${date.month}/${date.day}",
        "lang": "fr",
      },
    );
    if (forecastByCityAndNameResponse.statusCode != 200) {
      throw GetForecastByCityAndDateException(
          "Impossible de récupérer les prévisions du $date pour $city (Error ${forecastByCityAndNameResponse.statusCode})");
    }
    return WeatherData.fromJson(jsonDecode(forecastByCityAndNameResponse.body));
  }
}
