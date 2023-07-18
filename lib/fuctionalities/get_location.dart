import 'package:geolocator/geolocator.dart';

Future<Position?> getLocation() async {
  LocationPermission locationPermission;
  await Geolocator.checkPermission();
  locationPermission = await Geolocator.requestPermission();
  if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
    print("when denied");
    return null;
  } else {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    return position;
  }
}
