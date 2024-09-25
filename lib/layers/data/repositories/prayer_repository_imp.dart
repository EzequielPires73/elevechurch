import 'package:elevechurch/core/error/exeptions.dart';
import 'package:elevechurch/core/error/failure.dart';
import 'package:elevechurch/layers/data/datasources/prayer_datasouce.dart';
import 'package:elevechurch/layers/data/models/prayer_model.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';

class PrayerRepositoryImp extends PrayerRepository {
  final PrayerDatasouce datasource;

  PrayerRepositoryImp({required this.datasource});

  @override
  Future<Prayer> createPrayer(Prayer prayer) async {
    try {
      final response =
          await datasource.createPrayer(PrayerModel.fromEntity(prayer));
      return response.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<Prayer>> findMyPrayers() async {
    try {
      final response = await datasource.findMyPrayers();
      return response.map((e) => e.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<Prayer> findPrayer(String id) async {
    try {
      final response = await datasource.findPrayer(id);
      return response.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<Prayer>> findPrayers() async {
    try {
      final response = await datasource.findPrayers();
      return response.map((e) => e.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<Prayer>> findPrayersByReason(String reason) async {
    try {
      final response = await datasource.findPrayersByReason(reason);
      return response.map((e) => e.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<Prayer>> findPraying() async {
    try {
      final response = await datasource.findPraying();
      return response.map((e) => e.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<bool> removePrayer(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Prayer> updatePrayer(String id, Prayer prayer) {
    throw UnimplementedError();
  }

  @override
  Future<Prayer> changePraying(int id) async {
    try {
      final response = await datasource.changePraying(id);
      return response;
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}

final List<ReasonOption> reasonOptions = [
  ReasonOption(id: 1, name: "Pessoal", enumValue: "pessoal"),
  ReasonOption(id: 2, name: "Crescimento", enumValue: "crescimento"),
  ReasonOption(id: 3, name: "Estudos", enumValue: "estudos"),
  ReasonOption(id: 4, name: "Família", enumValue: "familia"),
  ReasonOption(id: 5, name: "Matrimonial", enumValue: "matrimonial"),
  ReasonOption(id: 6, name: "Conversão", enumValue: "conversao"),
  ReasonOption(id: 7, name: "Missões", enumValue: "missoes"),
  ReasonOption(id: 8, name: "Viagem", enumValue: "viagem"),
  ReasonOption(id: 9, name: "Finanças", enumValue: "financas"),
  ReasonOption(id: 10, name: "Trabalho", enumValue: "trabalho"),
  ReasonOption(id: 11, name: "Saúde", enumValue: "saude"),
  ReasonOption(id: 12, name: "Igreja", enumValue: "igreja"),
  ReasonOption(id: 13, name: "Ação de Graças", enumValue: "acao_de_gracas"),
  ReasonOption(id: 14, name: "Nação", enumValue: "nacao"),
  ReasonOption(id: 15, name: "Outro", enumValue: "outro"),
];
