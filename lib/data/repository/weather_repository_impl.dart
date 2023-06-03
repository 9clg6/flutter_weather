import 'package:flutter_weather/data/data_sources/weather_remote_datasource_impl.dart';
import 'package:flutter_weather/domain/entity/forecast.dart';
import 'package:flutter_weather/domain/entity/location.dart';
import 'package:flutter_weather/domain/entity/weather.dart';
import 'package:flutter_weather/foundation/weather_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final remoteDataSource = WeatherRemoteDataSourceImpl();

  @override
  Future<Weather> getCurrentCityWeather(String city) {
    // TODO: implement getCurrentWeather
    throw UnimplementedError();
  }

  @override
  Future<List<Weather>> getWeatherForecast(String city) {
    // TODO: implement getWeatherForecast
    throw UnimplementedError();
  }

  @override
  Future<(Weather, Location)>? getCurrentLocationWeather(Position location) {
    try {
      return remoteDataSource.getCurrentLocationWeather(location);
    } catch (e) {
      Logger().e("Can't fetch current weather: $e");
      return null;
    }
  }

  @override
  Future<List<Forecast>>? getForecastForLocation(Position location, int days) {
    try {
      return remoteDataSource.getForecastForLocation(location, days);
    } catch (e) {
      Logger().e("Can't fetch forecast weather: $e");
      return null;
    }
  }
}
