import 'package:elevechurch/layers/data/models/address_model.dart';
import 'package:elevechurch/layers/data/models/church_model.dart';
import 'package:elevechurch/layers/data/models/ecclesiastical_position_model.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    super.address,
    super.avatar,
    super.birthday,
    super.church,
    super.churchId,
    super.congregation,
    super.cpf,
    super.createdAt,
    super.dateBaptism,
    super.ecclesiasticalPosition,
    super.education,
    super.email,
    super.gender,
    super.id,
    super.maritalStatus,
    super.memberSince,
    super.notificationToken,
    super.observations,
    super.password,
    super.phone,
    super.profession,
    super.rg,
    super.type,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var address = json['address'] != null ? json['address'] as List : [];

    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      cpf: json['cpf'],
      rg: json['rg'],
      avatar: json['avatar'],
      gender: json['gender'],
      education: json['education'],
      maritalStatus: json['maritalStatus'],
      profession: json['profession'],
      birthday: json['birthday'],
      dateBaptism: json['dateBaptism'],
      memberSince: json['memberSince'],
      congregation: json['congregation'] != null
          ? ChurchModel.fromJson(json['congregation'])
          : null,
      church:
          json['church'] != null ? ChurchModel.fromJson(json['church']) : null,
      address: address.isNotEmpty ? AddressModel.fromJson(address[0]) : null,
      ecclesiasticalPosition: json['ecclesiasticalPosition'] != null
          ? EcclesiasticalPositionModel.fromJson(json['ecclesiasticalPosition'])
          : null,
    );
  }

  toJson() {
    return {
      'name': name,
      'email': email,
      'cpf': cpf,
      'rg': rg,
      'profession': profession,
      'birthday': birthday,
      'dateBaptism': dateBaptism,
      'memberSince': memberSince,
      'phone': phone,
      'gender': gender,
      'congregationId': congregation?.id,
      'positionId': ecclesiasticalPosition,
      'education': education,
      'maritalStatus': maritalStatus,
      'address': address,
      'password': password,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      cpf: user.cpf,
      phone: user.phone,
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      cpf: cpf,
      phone: phone,
    );
  }
}
