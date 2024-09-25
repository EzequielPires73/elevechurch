import 'package:elevechurch/core/network/api_service.dart';
import 'package:elevechurch/layers/data/models/prayer_model.dart';

abstract class PrayerDatasouce {
  Future<PrayerModel> createPrayer(PrayerModel prayer);
  Future<PrayerModel> findPrayer(String id);
  Future<List<PrayerModel>> findPrayersByReason(String reason);
  Future<PrayerModel> updatePrayer(String id, PrayerModel prayer);
  Future<bool> removePrayer(String id);
  Future<List<PrayerModel>> findPrayers();
  Future<List<PrayerModel>> findMyPrayers();
  Future<List<PrayerModel>> findPraying();
  Future<PrayerModel> changePraying(int id);
}

class PrayerDatasouceImp extends PrayerDatasouce {
  final ApiService apiService;

  PrayerDatasouceImp({required this.apiService});

  @override
  Future<PrayerModel> createPrayer(PrayerModel prayer) async {
    final response = await apiService.post('prayers', data: prayer.toJson());
    return PrayerModel.fromJson(response['data']);
  }

  @override
  Future<List<PrayerModel>> findMyPrayers() async {
    final response = await apiService.get('prayers');
    var results = response['data'] as List;

    return results.map((json) => PrayerModel.fromJson(json)).toList();
  }

  @override
  Future<PrayerModel> findPrayer(String id) async {
    final response = await apiService.get('prayers');

    return PrayerModel.fromJson(response['data']);
  }

  @override
  Future<List<PrayerModel>> findPrayers() async {
    final response = await apiService.get('prayers');
    var results = response['data'] as List;

    return results.map((json) => PrayerModel.fromJson(json)).toList();
  }

  @override
  Future<List<PrayerModel>> findPrayersByReason(String reason) async {
    final response = await apiService.get('prayers');
    var results = response['data'] as List;

    return results.map((json) => PrayerModel.fromJson(json)).toList();
  }

  @override
  Future<List<PrayerModel>> findPraying() async {
    final response = await apiService.get('prayers');
    var results = response['data'] as List;

    return results.map((json) => PrayerModel.fromJson(json)).toList();
  }

  @override
  Future<bool> removePrayer(String id) async {
    await apiService.delete('prayers');

    return true;
  }

  @override
  Future<PrayerModel> updatePrayer(String id, PrayerModel prayer) async {
    final response =
        await apiService.patch('prayers/$id', data: prayer.toJson());

    return PrayerModel.fromJson(response['data']);
  }

  @override
  Future<PrayerModel> changePraying(int id) async {
    final response =
        await apiService.post('public/prayers/praying/$id', data: null);

    return PrayerModel.fromJson(response['data']);
  }
}
