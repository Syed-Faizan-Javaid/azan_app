import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

  return position;
}
