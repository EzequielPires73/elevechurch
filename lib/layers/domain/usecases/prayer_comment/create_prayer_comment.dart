import 'package:elevechurch/layers/domain/repositories/prayer_comment_repository.dart';

class CreatePrayerComment {
  final PrayerCommentRepository repository;

  CreatePrayerComment({required this.repository});

  Future<bool> call(int id, String message) async {
    return await repository.createPrayerComment(id, message);
  }
}
