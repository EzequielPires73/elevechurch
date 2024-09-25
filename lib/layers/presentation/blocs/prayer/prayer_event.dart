import 'package:elevechurch/layers/domain/entities/prayer.dart';

abstract class PrayerEvent {
  const PrayerEvent();
}

class LoadPrayersEvent extends PrayerEvent {}

class CreatePrayerEvent extends PrayerEvent {
  final Prayer prayer;

  const CreatePrayerEvent({required this.prayer});
}

class UpdatePrayerEvent extends PrayerEvent {
  final String id;
  final Prayer prayer;

  const UpdatePrayerEvent({required this.id, required this.prayer});
}

class FindPrayerEvent extends PrayerEvent {
  final String id;

  const FindPrayerEvent({required this.id});
}

class DeletePrayerEvent extends PrayerEvent {
  final String id;

  const DeletePrayerEvent({required this.id});
}
