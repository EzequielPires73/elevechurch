import 'package:elevechurch/layers/domain/entities/auth_response.dart';
import 'package:elevechurch/layers/domain/repositories/auth_repository.dart';

class LoadUser {
  final AuthRepository repository;

  LoadUser({required this.repository});

  Future<AuthResponse?> call() async {
    return await repository.loadUser();
  }
}
