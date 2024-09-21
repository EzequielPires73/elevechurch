import 'package:elevechurch/layers/domain/entities/user.dart';

abstract class AuthState {
  final User? user;
  final String? token;

  AuthState({this.token, this.user});
}

class AuthenticationInitial extends AuthState {}

class AuthenticationLoading extends AuthState {}

class AuthenticatedState extends AuthState {
  AuthenticatedState({required super.user, required super.token});
}

class UnauthenticatedState extends AuthState {}

class AuthenticationFailure extends AuthState {
  final String error;

  AuthenticationFailure({required this.error});
}
