import 'package:elevechurch/layers/domain/entities/user.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserCreatedState extends UserState {
  final User user;

  UserCreatedState({required this.user});
}

class UserUpdatedState extends UserState {
  final User user;

  UserUpdatedState({required this.user});
}

class UserOperationFailureState extends UserState {
  final String error;

  UserOperationFailureState({required this.error});
}

class UserFound extends UserState {
  final User user;

  UserFound({required this.user});
}

class UserNotFound extends UserState {}
