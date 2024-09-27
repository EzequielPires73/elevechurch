import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class UpdatePrayer {
  final PrayerRepository repository;

  UpdatePrayer({required this.repository});

  Future<Prayer> call(int id, Prayer prayer) async {
    return await repository.updatePrayer(id, prayer);
  }
}
