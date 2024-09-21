import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/domain/repositories/user_repository.dart';

class CreateUser {
  final UserRepository repository;

  CreateUser({required this.repository});

  Future<User> call(User user) async {
    return await repository.createUser(user);
  }
}
