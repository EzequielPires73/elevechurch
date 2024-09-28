import 'package:elevechurch/layers/domain/repositories/prayer_comment_repository.dart';

class RemovePrayerComment {
  final PrayerCommentRepository repository;

  RemovePrayerComment({required this.repository});

  Future<bool> call(int id) async {
    return await repository.removePrayerComment(id);
  }
}
