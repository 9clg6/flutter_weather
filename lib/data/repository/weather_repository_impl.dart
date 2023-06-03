import 'package:flutter_weather/data/data_sources/weather_remote_datasource_impl.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/foundation/weather_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final remoteDataSource = WeatherRemoteDataSourceImpl();

  @override
  Future<WeatherData>? getForecastForLocation(Position location, int days) {
    try {
      return remoteDataSource.getForecastForLocation(location, days);
    } catch (e) {
      Logger().e("Can't fetch forecast weather: $e");
      return null;
    }
  }
}
