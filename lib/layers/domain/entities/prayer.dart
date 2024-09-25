import 'package:elevechurch/layers/domain/entities/church.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';

class PrayerComment {
  int? id;
  String content;
  User? user;
  String? createdAt;

  PrayerComment({
    required this.content,
    required this.user,
    this.id,
    this.createdAt,
  });
}

class Prayer {
  int? id;
  String reason;
  String description;
  bool? receiveVisit;
  bool? receiveCall;
  bool? postOnWall;
  bool? active;
  String? image;
  String? createdAt;
  String? updatedAt;
  Church? church;
  User? user;
  List<PrayerComment>? comments;
  List<User>? praying;

  Prayer({
    required this.reason,
    required this.description,
    this.user,
    this.id,
    this.active,
    this.church,
    this.comments,
    this.createdAt,
    this.image,
    this.postOnWall,
    this.praying,
    this.receiveCall,
    this.receiveVisit,
    this.updatedAt,
  });
}

class ReasonOption {
  final int id;
  final String name;
  final String enumValue;

  ReasonOption({required this.id, required this.name, required this.enumValue});
}
