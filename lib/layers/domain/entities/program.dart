import 'package:elevechurch/layers/domain/entities/church.dart';

class Program {
  int id;
  String title;
  String? description;
  String? image;
  bool? pushNotification;
  bool? live;
  bool? active;
  bool? recurrent;
  String? date;
  Church? church;
  String? monday;
  String? tuesday;
  String? wednesday;
  String? thursday;
  String? friday;
  String? saturday;
  String? sunday;
  String? createdAt;
  String? updatedAt;

  Program({
    required this.id,
    required this.title,
    this.active,
    this.church,
    this.createdAt,
    this.date,
    this.description,
    this.friday,
    this.image,
    this.live,
    this.monday,
    this.pushNotification,
    this.recurrent,
    this.saturday,
    this.sunday,
    this.thursday,
    this.tuesday,
    this.updatedAt,
    this.wednesday,
  });
}
