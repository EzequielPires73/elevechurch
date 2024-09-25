import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class RemovePrayer {
  final PrayerRepository repository;

  RemovePrayer({required this.repository});

  Future<bool> call(String id) async {
    return await repository.removePrayer(id);
  }
}
