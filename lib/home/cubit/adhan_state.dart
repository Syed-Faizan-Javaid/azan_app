part of 'adhan_cubit.dart';

@immutable
abstract class AdhanState {}

class AdhanInitial extends AdhanState {}

class FetchNamazTiming extends AdhanState {
  Adhan adhan;
  PrayerTimeModel selectedPrayerTimeModel;
  FetchNamazTiming({required this.adhan, required this.selectedPrayerTimeModel});
  @override
  List<Object> get props => [adhan, selectedPrayerTimeModel];
}

class LocationIsDisabled extends AdhanState {
  @override
  List<Object> get props => [];
}

class UpdatePrayerTimes extends AdhanState {
  PrayerTimeModel selectedPrayerTimeModel;
  List<PrayerTimeModel> prayers;
  UpdatePrayerTimes({required this.prayers, required this.selectedPrayerTimeModel});
  @override
  List<Object> get props => [selectedPrayerTimeModel, prayers];
}
