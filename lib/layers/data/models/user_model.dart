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
    final Map<String, dynamic> data = {};

    data['name'] = name;
    if (email != null) {
      data['email'] = email;
    }
    if (cpf != null) {
      data['cpf'] = cpf;
    }
    if (rg != null) {
      data['rg'] = rg;
    }
    if (profession != null) {
      data['profession'] = profession;
    }
    if (birthday != null) {
      data['birthday'] = birthday;
    }
    if (dateBaptism != null) {
      data['dateBaptism'] = dateBaptism;
    }
    if (memberSince != null) {
      data['memberSince'] = memberSince;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (gender != null) {
      data['gender'] = gender;
    }
    if (congregation?.id != null) {
      data['congregationId'] = congregation?.id;
    }
    if (education != null) {
      data['education'] = education;
    }
    if (maritalStatus != null) {
      data['maritalStatus'] = maritalStatus;
    }
    if (address != null) {
      data['address'] = address;
    }
    if (avatar != null) {
      data['avatar'] = avatar;
    }
    if (password != null) {
      data['password'] = password;
    }
    if (id != null) {
      data['id'] = id;
    }
    if (ecclesiasticalPosition != null) {
      data['positionId'] = ecclesiasticalPosition;
    }

    return data;
  }

  factory UserModel.fromEntity(User user) {
    if (user.password != null) {
      return UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        cpf: user.cpf,
        phone: user.phone,
        password: user.password,
      );
    } else {
      return UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        cpf: user.cpf,
        phone: user.phone,
      );
    }
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
