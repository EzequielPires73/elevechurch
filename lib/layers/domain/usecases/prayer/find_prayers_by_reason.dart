import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class FindPrayersByReason {
  final PrayerRepository repository;

  FindPrayersByReason({required this.repository});

  Future<List<Prayer>> call(String reason) async {
    return await repository.findPrayersByReason(reason);
  }
}
