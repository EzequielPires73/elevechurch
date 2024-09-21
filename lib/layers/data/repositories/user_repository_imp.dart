import 'package:elevechurch/core/error/exeptions.dart';
import 'package:elevechurch/core/error/failure.dart';
import 'package:elevechurch/layers/data/datasources/user_datasource.dart';
import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImp({required this.datasource});

  @override
  Future<User> createUser(User user) async {
    try {
      final userModel = await datasource.createUser(UserModel.fromEntity(user));
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<User> findUser(String id) async {
    try {
      final userModel = await datasource.findUser(id);
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<User>> findUsersByType(String type) {
    // TODO: implement findUsersByType
    throw UnimplementedError();
  }

  @override
  Future<User> removeUser(String id) {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(String id, User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
