import 'package:elevechurch/layers/domain/entities/church.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';

class EcclesiasticalPosition {
  int id;
  int code;
  String abbreviation;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;
  Church? church;
  List<User>? users;

  EcclesiasticalPosition({
    required this.id,
    required this.code,
    required this.abbreviation,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.church,
    required this.users,
  });
}
