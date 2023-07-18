import 'dart:async';

import 'package:azan_app/home/components/lower_portion.dart';
import 'package:azan_app/home/components/upper_portion.dart';
import 'package:azan_app/home/cubit/adhan_cubit.dart';
import 'package:azan_app/model/prayer_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage() {
    print("const");
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late Timer _timer;
  String time = DateFormat('hh:mm').format(DateTime.now());
  String zone = DateFormat('a').format(DateTime.now());
  String? remainingTime;
  PrayerTimeModel? prayerTimeModel;
  late AdhanCubit _adhanCubit;
  List<PrayerTimeModel> prayers = [];
  bool callFunction = false;
  String? prayerName;
  DateTime now = DateTime.now();
  String? islamicDate;

  @override
  void initState() {
    _adhanCubit = context.read<AdhanCubit>();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _adhanCubit.checkPermission();
    }
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('E, MMM dd');
    final String formattedDate = formatter.format(date);
    return formattedDate;
  }

  void _update() {
    DateTime now = DateTime.now();
    final HijriCalendar _today = HijriCalendar.now();

    if (prayers.isNotEmpty) {
      PrayerTimeModel zoharPrayer = prayers[1];
      PrayerTimeModel fajarPrayer = prayers[0];
      if (now.isAfter(zoharPrayer.namazStartTime!) && now.isBefore(zoharPrayer.namazEndTime!) ||
          now.hour == zoharPrayer.namazStartTime?.hour && now.minute == zoharPrayer.namazStartTime?.minute) {
        List item = _adhanCubit.getListForUpdatingPrayerTimes();
        prayerTimeModel = item[0];
        prayers = item[1];
      } else if (now.isAfter(fajarPrayer.namazStartTime!) && now.isBefore(fajarPrayer.namazEndTime!) ||
          now.hour == fajarPrayer.namazStartTime?.hour && now.minute == fajarPrayer.namazStartTime?.minute) {
        List item = _adhanCubit.getListForUpdatingPrayerTimes();
        prayerTimeModel = item[0];
        prayers = item[1];
      }
    }
    Duration duration = getDuration(prayerTimeModel?.namazStartTime ?? DateTime.now(), prayerTimeModel?.namazEndTime ?? DateTime.now());
    setState(() {
      islamicDate = '${_today.toFormat('dd MMMM')}|${formatDate(DateTime.now())}';
      if (duration.isNegative) {
        List item = _adhanCubit.getListForUpdatingPrayerTimes();
        prayerTimeModel = item[0];
        prayers = item[1];
      }
      time = DateFormat('hh:mm').format(DateTime.now());
      zone = DateFormat('a').format(DateTime.now());
      remainingTime = getRemainingTime(prayerTimeModel?.namazStartTime ?? DateTime.now(), prayerTimeModel?.namazEndTime ?? DateTime.now());
      prayerName = prayerTimeModel?.prayerName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdhanCubit, AdhanState>(
      builder: (context, state) {
        if (state is FetchNamazTiming) {
          prayerTimeModel = state.selectedPrayerTimeModel;
          prayers = state.adhan.prayers;
          return Scaffold(
              body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: const BoxConstraints(minWidth: 800),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xFFE7F3F0),
                  Color(0xFFFFC265),
                ],
                begin: Alignment(-0, -0.801),
                end: Alignment(-0, 2.964),
              )),
              child: Column(
                children: [
                  UpperPortion(
                    adhan: state.adhan,
                    prayerTimeModel: prayerTimeModel ?? PrayerTimeModel(),
                    time: time,
                    zone: zone,
                    todayIslamicDate: islamicDate ?? "",
                  ),
                  LowerPortion(
                    prayers: prayers,
                    prayerTimeModel: prayerTimeModel ?? PrayerTimeModel(),
                    remainingTime: remainingTime ?? "",
                    prayerName: prayerName ?? "",
                  )
                ],
              ),
            ),
          ));
        } else if (state is LocationIsDisabled) {
          return Scaffold(
            body: Column(
              children: [
                const Center(
                  child:
                      Text("Location Service is Disabled.Please Enable your location.if location is already enabled then restart your application"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Geolocator.openLocationSettings();
                    },
                    child: const Text("Enable Location"))
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  String getRemainingTime(DateTime? startTime, DateTime? endTime) {
    DateTime now = DateTime.now();
    Duration duration = endTime!.difference(now);
    var min = duration.inMinutes % 60;
    String totalTime = "${duration.inHours} Hours $min Minutes";
    return totalTime;
  }

  Duration getDuration(DateTime? startTime, DateTime? endTime) {
    DateTime now = DateTime.now();
    Duration duration = endTime!.difference(now);
    return duration;
  }
}
