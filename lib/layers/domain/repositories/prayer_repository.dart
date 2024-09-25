import 'package:elevechurch/layers/domain/entities/prayer.dart';

abstract class PrayerRepository {
  Future<Prayer> createPrayer(Prayer prayer);
  Future<Prayer> findPrayer(String id);
  Future<List<Prayer>> findPrayersByReason(String reason);
  Future<Prayer> updatePrayer(String id, Prayer prayer);
  Future<bool> removePrayer(String id);
  Future<List<Prayer>> findPrayers();
  Future<List<Prayer>> findMyPrayers();
  Future<List<Prayer>> findPraying();
}
