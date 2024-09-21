import 'package:elevechurch/layers/domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    required super.name,
    required super.complement,
    required super.number,
    required super.zipcode,
    required super.city,
    required super.state,
    required super.district,
    required super.route,
    super.id,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'],
      complement: json['complement'],
      number: json['number'],
      zipcode: json['zipcode'],
      city: json['city'],
      state: json['state'],
      district: json['district'],
      route: json['route'],
    );
  }
}
