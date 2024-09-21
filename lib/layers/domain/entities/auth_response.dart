import 'package:elevechurch/layers/domain/entities/user.dart';

class AuthResponse {
  final User user;
  final String token;

  AuthResponse({required this.token, required this.user});
}
