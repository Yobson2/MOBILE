import 'package:geolocator/geolocator.dart';

class LocationData {
  final double latitude;
  final double longitude;

  LocationData(this.latitude, this.longitude);
}

class LocationService {
  Future<LocationData> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LocationData(position.latitude, position.longitude);
    } catch (e) {
      print("Error: $e");
      return LocationData(0.0, 0.0); 
    }
  }
}
