import 'package:elevechurch/layers/domain/entities/auth_response.dart';
import 'package:elevechurch/layers/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn({required this.repository});

  Future<AuthResponse> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
