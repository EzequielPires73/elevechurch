import 'package:elevechurch/layers/domain/entities/address.dart';
import 'package:elevechurch/layers/domain/entities/church.dart';
import 'package:elevechurch/layers/domain/entities/ecclesiastical_position.dart';

class User {
  int? id;
  String name;
  String? email;
  String? phone;
  String? cpf;
  String? avatar;
  String? password;
  String? birthday;
  String? maritalStatus;
  String? rg;
  String? profession;
  String? memberSince;
  String? dateBaptism;
  String? observations;
  String? education;
  String? gender;
  String? type;
  EcclesiasticalPosition? ecclesiasticalPosition;
  String? notificationToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  Church? church;
  Church? congregation;
  Address? address;
  int? churchId;

  User({
    required this.name,
    this.address,
    this.avatar,
    this.birthday,
    this.church,
    this.churchId,
    this.congregation,
    this.cpf,
    this.createdAt,
    this.dateBaptism,
    this.ecclesiasticalPosition,
    this.education,
    this.email,
    this.gender,
    this.id,
    this.maritalStatus,
    this.memberSince,
    this.notificationToken,
    this.observations,
    this.password,
    this.phone,
    this.profession,
    this.rg,
    this.type,
    this.updatedAt,
  });
}
