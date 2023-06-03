import 'package:flutter_weather/data/data_sources/location_datasource_impl.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocation {
  final locationRepository = LocationDataSourceImpl();

  Future<Position> getCurrentLocation() async {
    return locationRepository.getCurrentLocation();
  }
}
