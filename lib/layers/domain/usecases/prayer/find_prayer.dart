import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class FindPrayer {
  final PrayerRepository repository;

  FindPrayer({required this.repository});

  Future<Prayer> call(String id) async {
    return await repository.findPrayer(id);
  }
}
