import 'package:flutter_weather/data/data_sources/location_datasource_impl.dart';
import 'package:flutter_weather/foundation/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl extends LocationRepository {
  final _locationDataSource = LocationDataSourceImpl();

  @override
  Future<Position> getCurrentLocation() =>
      _locationDataSource.getCurrentLocation();
}
