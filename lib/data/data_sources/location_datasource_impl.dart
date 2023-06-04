import 'package:flutter_weather/domain/exception/no_location_found_exception.dart';
import 'package:flutter_weather/foundation/location_datasource.dart';
import 'package:geolocator/geolocator.dart';

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw NoLocationFoundException("Le service de localisation est désactivé.");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw NoLocationFoundException(
            "Pour afficher la météo dans la ville actuelle vous devez autoriser l'accès à la localisation.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw NoLocationFoundException(
          "Pour afficher la météo dans la ville actuelle vous devez autoriser l'accès à la localisation.");
    }
    return Geolocator.getCurrentPosition();
  }
}
