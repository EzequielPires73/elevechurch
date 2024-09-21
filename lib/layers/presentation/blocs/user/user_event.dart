import 'package:elevechurch/layers/domain/entities/user.dart';

abstract class UserEvent {}

class UserInitialEvent extends UserEvent {}

class CreateUserEvent extends UserEvent {
  final User user;

  CreateUserEvent({required this.user});
}

class FindUserEvent extends UserEvent {
  final String id;

  FindUserEvent({required this.id});
}
