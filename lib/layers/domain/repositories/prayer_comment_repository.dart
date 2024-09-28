abstract class PrayerCommentRepository {
  Future<bool> createPrayerComment(int id, String message);
  Future<bool> removePrayerComment(int id);
}
