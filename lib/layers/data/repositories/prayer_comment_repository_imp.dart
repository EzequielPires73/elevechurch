import 'package:elevechurch/core/error/exeptions.dart';
import 'package:elevechurch/core/error/failure.dart';
import 'package:elevechurch/layers/data/datasources/prayer_comment_datasource.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_comment_repository.dart';

class PrayerCommentRepositoryImp extends PrayerCommentRepository {
  final PrayerCommentDatasource datasource;

  PrayerCommentRepositoryImp({required this.datasource});

  @override
  Future<bool> createPrayerComment(int id, String message) async {
    try {
      final response = await datasource.createPrayerComment(id, message);
      return response;
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<bool> removePrayerComment(int id) async {
    try {
      final response = await datasource.removePrayerComment(id);
      return response;
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
