import 'package:flutter_weather/data/data_sources/location_datasource_impl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class GetCurrentLocation {
  final locationRepository = LocationDataSourceImpl();

  Future<Position> getCurrentLocation() async {
    Logger().i("Get current location");
    return locationRepository.getCurrentLocation();
  }
}
