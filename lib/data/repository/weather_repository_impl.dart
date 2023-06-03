import 'package:flutter_weather/data/data_sources/weather_remote_datasource_impl.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:flutter_weather/foundation/weather_repository.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final remoteDataSource = WeatherRemoteDataSourceImpl();

  @override
  Future<WeatherData>? getForecastByLocation(Position? location, String? city, int days) {
    return remoteDataSource.getForecastByLocation(location, city, days);
  }

  @override
  Future<WeatherData>? getForecastByCityAndDate(String city, DateTime date) {
    return remoteDataSource.getForecastByCityAndDate(city, date);
  }
}
