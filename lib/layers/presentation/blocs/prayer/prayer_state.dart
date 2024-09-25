import 'package:elevechurch/layers/domain/entities/prayer.dart';

abstract class PrayerState {
  const PrayerState();
}

class PrayerInitialState extends PrayerState {
  const PrayerInitialState();
}

class PrayerLoadingState extends PrayerState {}

class PrayerCreatedState extends PrayerState {
  final Prayer prayer;

  const PrayerCreatedState({required this.prayer});
}

class PrayerUpdatedState extends PrayerState {
  final Prayer prayer;

  const PrayerUpdatedState({required this.prayer});
}

class PrayerRemovededState extends PrayerState {}

class PrayersLoadedState extends PrayerState {
  final List<Prayer> prayers;

  const PrayersLoadedState({required this.prayers});
}

class PrayerFoundState extends PrayerState {
  final Prayer prayer;

  const PrayerFoundState({required this.prayer});
}

class PrayerNotFoundState extends PrayerState {
  const PrayerNotFoundState();
}

class PrayerErrorState extends PrayerState {
  final String error;

  const PrayerErrorState({required this.error});
}
