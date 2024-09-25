import 'package:elevechurch/layers/data/models/church_model.dart';
import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';

class PrayerCommentModel extends PrayerComment {
  PrayerCommentModel({
    required super.id,
    required super.content,
    super.createdAt,
    super.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt,
      'user': user != null ? UserModel.fromEntity(user!).toJson() : null,
    };
  }

  factory PrayerCommentModel.fromEntity(PrayerComment comment) {
    return PrayerCommentModel(
      id: comment.id,
      content: comment.content,
      createdAt: comment.createdAt,
      user: comment.user,
    );
  }

  factory PrayerCommentModel.fromJson(Map<String, dynamic> json) {
    return PrayerCommentModel(
      id: json['id'],
      content: json['content'],
      createdAt: json['createdAt'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  PrayerComment toEntity() {
    return PrayerComment(
      id: id,
      content: content,
      createdAt: createdAt,
      user: user,
    );
  }
}

class PrayerModel extends Prayer {
  PrayerModel({
    required super.id,
    required super.reason,
    required super.description,
    super.active,
    super.createdAt,
    super.user,
    super.church,
    super.comments,
    super.image,
    super.postOnWall,
    super.praying,
    super.receiveCall,
    super.receiveVisit,
    super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    var userFormated = user != null ? UserModel.fromEntity(user!) : null;
    return {
      if (id != null) 'id': id,
      'reason': reason,
      'description': description,
      'active': active,
      'user': userFormated?.toJson(),
      'comments': comments,
      'image': image,
      'postOnWall': postOnWall,
      'receiveCall': receiveCall,
      'receiveVisit': receiveVisit,
      'userId': userFormated?.id,
    };
  }

  factory PrayerModel.fromEntity(Prayer prayer) {
    return PrayerModel(
      id: prayer.id,
      reason: prayer.reason,
      description: prayer.description,
      user: prayer.user,
      active: prayer.active,
      church: prayer.church,
      comments: prayer.comments,
      createdAt: prayer.createdAt,
      image: prayer.image,
      postOnWall: prayer.postOnWall,
      praying: prayer.praying,
      receiveCall: prayer.receiveCall,
      receiveVisit: prayer.receiveVisit,
      updatedAt: prayer.updatedAt,
    );
  }

  factory PrayerModel.fromJson(Map<String, dynamic> json) {
    var list = json['praying'] != null ? json['praying'] as List : [];
    List<UserModel> praying = list.map((e) => UserModel.fromJson(e)).toList();

    var listComments = json['comments'] != null ? json['comments'] as List : [];
    List<PrayerCommentModel> comments =
        listComments.map((e) => PrayerCommentModel.fromJson(e)).toList();

    return PrayerModel(
      id: json['id'],
      reason: json['reason'],
      description: json['description'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      active: json['active'],
      church:
          json['church'] != null ? ChurchModel.fromJson(json['church']) : null,
      comments: comments,
      createdAt: json['createdAt'],
      image: json['image'],
      postOnWall: json['postOnWall'],
      praying: praying,
      receiveCall: json['receiveCall'],
      receiveVisit: json['receiveVisit'],
      updatedAt: json['updatedAt'],
    );
  }

  Prayer toEntity() {
    return Prayer(
      id: id,
      reason: reason,
      description: description,
      user: user,
      active: active,
      church: church,
      comments: comments,
      createdAt: createdAt,
      image: image,
      postOnWall: postOnWall,
      praying: praying,
      receiveCall: receiveCall,
      receiveVisit: receiveVisit,
      updatedAt: updatedAt,
    );
  }
}
