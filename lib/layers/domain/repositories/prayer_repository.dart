import 'package:elevechurch/layers/domain/entities/prayer.dart';

abstract class PrayerRepository {
  Future<Prayer> createPrayer(Prayer prayer);
  Future<Prayer> findPrayer(int id);
  Future<List<Prayer>> findPrayersByReason(String reason);
  Future<Prayer> updatePrayer(int id, Prayer prayer);
  Future<bool> removePrayer(int id);
  Future<List<Prayer>> findPrayers();
  Future<List<Prayer>> findMyPrayers();
  Future<List<Prayer>> findPraying();
  Future<Prayer> changePraying(int id);
  Future<Prayer> commentPrayer(int id, String message);
}
