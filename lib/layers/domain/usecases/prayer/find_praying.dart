import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class FindPraying {
  final PrayerRepository repository;

  FindPraying({required this.repository});

  Future<List<Prayer>> call() async {
    return await repository.findPraying();
  }
}
