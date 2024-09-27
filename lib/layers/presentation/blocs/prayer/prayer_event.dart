import 'package:elevechurch/layers/domain/entities/prayer.dart';

abstract class PrayerEvent {
  PrayerEvent();
}

class LoadPrayersEvent extends PrayerEvent {}

class LoadPrayingEvent extends PrayerEvent {}

class LoadMyPrayersEvent extends PrayerEvent {}

class CreatePrayerEvent extends PrayerEvent {
  final Prayer prayer;

  CreatePrayerEvent({required this.prayer});
}

class UpdatePrayerEvent extends PrayerEvent {
  final int id;
  final Prayer prayer;

  UpdatePrayerEvent({required this.id, required this.prayer});
}

class FindPrayerEvent extends PrayerEvent {
  final int id;

  FindPrayerEvent({required this.id});
}

class DeletePrayerEvent extends PrayerEvent {
  final int id;

  DeletePrayerEvent({required this.id});
}

class ChangePrayingEvent extends PrayerEvent {
  final int id;
  final bool? listPraying;
  final bool? listMyPrayers;
  final bool? viewPrayer;

  ChangePrayingEvent({
    required this.id,
    this.listMyPrayers,
    this.listPraying,
    this.viewPrayer,
  });
}

class CommentPrayerEvent extends PrayerEvent {
  final int id;
  final String message;

  CommentPrayerEvent({required this.id, required this.message});
}
