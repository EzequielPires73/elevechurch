import 'package:elevechurch/layers/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> createUser(User user);
  Future<User> findUser(String id);
  Future<List<User>> findUsersByType(String type);
  Future<User> updateUser(String id, User user);
  Future<User> removeUser(String id);
}
