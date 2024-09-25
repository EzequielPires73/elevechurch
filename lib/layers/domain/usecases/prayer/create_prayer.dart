import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class CreatePrayer {
  final PrayerRepository repository;

  CreatePrayer({required this.repository});

  Future<Prayer> call(Prayer prayer) async {
    return await repository.createPrayer(prayer);
  }
}
