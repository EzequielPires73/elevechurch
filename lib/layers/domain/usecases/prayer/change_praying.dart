import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class ChangePraying {
  final PrayerRepository repository;

  ChangePraying({required this.repository});

  Future<Prayer> call(int id) async {
    return await repository.changePraying(id);
  }
}
