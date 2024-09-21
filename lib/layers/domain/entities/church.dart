import 'package:elevechurch/layers/domain/entities/address.dart';

class Church {
  int? id;
  String name;
  String email;
  String? phone;
  String? cnpj;
  String? password;
  String? instagram;
  String? youtube;
  String? facebook;
  String? description;
  String? history;
  String? mission;
  String? values;
  String? vision;
  String? banner;
  String? logo;
  bool? active;
  Address? address;

  Church({
    required this.name,
    required this.email,
    required this.phone,
    this.id,
    this.cnpj,
    this.active,
    this.banner,
    this.description,
    this.facebook,
    this.history,
    this.instagram,
    this.logo,
    this.mission,
    this.password,
    this.values,
    this.vision,
    this.youtube,
    this.address,
  });
}
