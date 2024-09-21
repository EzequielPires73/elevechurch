class Address {
  final String? name;
  final String? complement;
  final String? number;
  final String? zipcode;
  final String? city;
  final String? state;
  final String? district;
  final String? route;
  int? id;

  Address({
    required this.name,
    required this.complement,
    required this.number,
    required this.zipcode,
    required this.city,
    required this.state,
    required this.district,
    required this.route,
    this.id,
  });
}
