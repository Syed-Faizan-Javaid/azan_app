import 'package:adhan_dart/adhan_dart.dart';
import 'package:timezone/timezone.dart' as tz;

void getAdhanTime(dynamic lat, dynamic long) {
  final timezone = tz.getLocation('America/New_York');
  DateTime date = tz.TZDateTime.from(DateTime.now(), timezone);
  Coordinates coordinates = Coordinates(lat, long);
  CalculationParameters params = CalculationMethod.MuslimWorldLeague();
  params.madhab = Madhab.Hanafi;
  PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params);

  DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr!, timezone);
  DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise!, timezone);
  DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr!, timezone);
  DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr!, timezone);
  DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib!, timezone);
  DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha!, timezone);
  print('fajar time $fajrTime');
}
