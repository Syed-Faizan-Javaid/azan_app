import 'package:adhan_dart/adhan_dart.dart';
import 'package:azan_app/fuctionalities/get_location.dart';
import 'package:azan_app/model/Adhan.dart';
import 'package:azan_app/model/prayer_time.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'adhan_state.dart';

class AdhanCubit extends Cubit<AdhanState> {
  AdhanCubit() : super(AdhanInitial());

  List<PrayerTimeModel> prayers = [];
  Position? position;
  Adhan adhan = Adhan();
  void getAdhanTimes(bool isEmit) async {
    getLocation();
    position = await getLocation();
    Coordinates coordinates = Coordinates(position!.latitude, position!.longitude);
    DateTime date = DateTime.now();
    CalculationParameters params = CalculationMethod.MuslimWorldLeague();
    params.madhab = Madhab.Hanafi;
    PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params);

    addPrayerData('Fajar', DateFormat('hh:mm a').format(prayerTimes.fajr!.toLocal()), DateFormat('h:mm a').format(prayerTimes.sunrise!.toLocal()),
        prayerTimes.fajr, prayerTimes.sunrise);
    addPrayerData('Dhuhr', DateFormat('h:mm a').format(prayerTimes.dhuhr!.toLocal()), DateFormat('h:mm a').format(prayerTimes.asr!.toLocal()),
        prayerTimes.dhuhr, prayerTimes.asr);
    addPrayerData('Asr', DateFormat('h:mm a').format(prayerTimes.asr!.toLocal()), DateFormat('h:mm a').format(prayerTimes.maghrib!.toLocal()),
        prayerTimes.asr, prayerTimes.maghrib);
    addPrayerData('Maghrib', DateFormat('h:mm a').format(prayerTimes.maghrib!.toLocal()), DateFormat('h:mm a').format(prayerTimes.isha!.toLocal()),
        prayerTimes.maghrib, prayerTimes.isha);
    addPrayerData('Isha', DateFormat('h:mm a').format(prayerTimes.isha!.toLocal()), DateFormat('h:mm a').format(prayerTimes.fajr!.toLocal()),
        prayerTimes.isha, prayerTimes.fajr,
        isEshaTime: true);
    adhan.prayers = prayers;
    PrayerTimeModel? prayerTimeModel = getActiveNamazPrayerModel(prayers);
    adhan.sunset = DateFormat('h:mm a').format(prayerTimes.maghrib!.toLocal());
    adhan.sunrise = DateFormat('h:mm a').format(prayerTimes.sunrise!.toLocal());
    if (isEmit == true) {
      emit(FetchNamazTiming(adhan: adhan, selectedPrayerTimeModel: prayerTimeModel ?? PrayerTimeModel()));
    }
  }

  List getListForUpdatingPrayerTimes() {
    bool eshaNamaz = false;
    List<PrayerTimeModel> updatedPrayerTimes = [];
    for (PrayerTimeModel prayerTimeModel in prayers) {
      if (prayerTimeModel.prayerName == "Isha") {
        eshaNamaz = true;
      }
      prayerTimeModel.isActiveTime =
          checkActivePrayerTime(prayerTimeModel.namazStartTime!.toLocal(), prayerTimeModel.namazEndTime!.toLocal(), isEshaTime: eshaNamaz);
      updatedPrayerTimes.add(prayerTimeModel);
    }
    PrayerTimeModel? prayerTimeModel = getActiveNamazPrayerModel(updatedPrayerTimes);
    List items = [prayerTimeModel, updatedPrayerTimes];
    return items;
  }

  addPrayerData(String prayerName, String startTime, String endTime, DateTime? startDateTime, DateTime? endDateTime, {bool? isEshaTime}) {
    PrayerTimeModel prayerTimeModel = PrayerTimeModel();
    prayerTimeModel.prayerName = prayerName;
    prayerTimeModel.startTime = startTime;
    prayerTimeModel.isActiveTime = checkActivePrayerTime(startDateTime!.toLocal(), endDateTime!.toLocal(), isEshaTime: isEshaTime);
    prayerTimeModel.endTime = endTime;
    prayerTimeModel.namazStartTime = startDateTime.toLocal();
    prayerTimeModel.namazEndTime = endDateTime.toLocal();
    prayers.add(prayerTimeModel);
  }

  bool checkActivePrayerTime(DateTime? startDateTime, DateTime? endDateTime, {bool? isEshaTime}) {
    bool isActiveNamaz = false;
    DateTime now = DateTime.now();
    if (now.isAfter(startDateTime!) && now.isBefore(endDateTime!)) {
      isActiveNamaz = true;
    } else if (isEshaTime == true) {
      if (now.isAfter(startDateTime)) {
        isActiveNamaz = true;
      }
    } else {}
    // else if (now.hour == startDateTime.hour && now.minute == startDateTime.minute && now.second > 30) {
    //   print("in  equal start");
    //   isActiveNamaz = true;
    // } else if (now.hour == endDateTime!.hour && now.minute == endDateTime.minute && now.second < 30) {
    //   print("in  equal end");
    //
    //   isActiveNamaz = true;
    // }
    return isActiveNamaz;
  }

  PrayerTimeModel? getActiveNamazPrayerModel(List<PrayerTimeModel> prayerTimes) {
    PrayerTimeModel? selectedPrayerTimeModel;
    for (PrayerTimeModel prayerTimeModel in prayerTimes) {
      if (prayerTimeModel.isActiveTime == true) {
        selectedPrayerTimeModel = prayerTimeModel;
      }
    }
    return selectedPrayerTimeModel;
  }
}
