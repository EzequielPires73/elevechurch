import 'package:elevechurch/layers/data/models/address_model.dart';
import 'package:elevechurch/layers/domain/entities/church.dart';

class ChurchModel extends Church {
  ChurchModel({
    required super.name,
    required super.email,
    required super.phone,
    super.id,
    super.cnpj,
    super.active,
    super.banner,
    super.description,
    super.facebook,
    super.history,
    super.instagram,
    super.logo,
    super.mission,
    super.password,
    super.values,
    super.vision,
    super.youtube,
    super.address,
  });

  factory ChurchModel.fromJson(Map<String, dynamic> json) {
    var address = json['address'] != null ? json['address'] as List : [];

    return ChurchModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      cnpj: json['cnpj'],
      password: json['password'],
      instagram: json['instagram'],
      youtube: json['youtube'],
      facebook: json['facebook'],
      description: json['description'],
      history: json['history'],
      mission: json['mission'],
      values: json['values'],
      vision: json['vision'],
      banner: json['banner'],
      logo: json['logo'],
      active: json['active'],
      address: address.isNotEmpty ? AddressModel.fromJson(address[0]) : null,
    );
  }
}
