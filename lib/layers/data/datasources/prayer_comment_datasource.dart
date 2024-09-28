import 'package:elevechurch/core/network/api_service.dart';

abstract class PrayerCommentDatasource {
  Future<bool> createPrayerComment(int id, String message);
  Future<bool> removePrayerComment(int id);
}

class PrayerCommentDatasourceImp extends PrayerCommentDatasource {
  final ApiService apiService;

  PrayerCommentDatasourceImp({required this.apiService});

  @override
  Future<bool> createPrayerComment(int id, String message) async {
    var res = await apiService.post('prayer-comments', data: {
      "prayerId": id,
      "content": message,
    });

    return res['success'];
  }

  @override
  Future<bool> removePrayerComment(int id) async {
    var res = await apiService.delete('prayer-comments/$id');

    return res['success'];
  }
}
