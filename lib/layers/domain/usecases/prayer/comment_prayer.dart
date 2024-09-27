import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class CommentPrayer {
  final PrayerRepository repository;

  CommentPrayer({required this.repository});

  Future<Prayer> call(int id, String message) async {
    return await repository.commentPrayer(id, message);
  }
}
