import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class FindPrayers {
  final PrayerRepository repository;

  FindPrayers({required this.repository});

  Future<List<Prayer>> call() async {
    return await repository.findPrayers();
  }
}
