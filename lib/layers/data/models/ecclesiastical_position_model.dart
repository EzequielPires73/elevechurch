import 'package:elevechurch/layers/data/models/church_model.dart';
import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/domain/entities/ecclesiastical_position.dart';

class EcclesiasticalPositionModel extends EcclesiasticalPosition {
  EcclesiasticalPositionModel({
    required super.id,
    required super.code,
    required super.abbreviation,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required super.church,
    required super.users,
  });

  factory EcclesiasticalPositionModel.fromJson(Map<String, dynamic> json) {
    return EcclesiasticalPositionModel(
      id: json['id'],
      code: json['code'],
      abbreviation: json['abbreviation'],
      name: json['name'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      church:
          json['church'] != null ? ChurchModel.fromJson(json['church']) : null,
      users: json['users'] != null
          ? (json['users'] as List).map((i) => UserModel.fromJson(i)).toList()
          : [],
    );
  }
}
