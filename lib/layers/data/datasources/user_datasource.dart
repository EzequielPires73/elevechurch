import 'package:elevechurch/core/network/api_service.dart';
import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';

abstract class UserDatasource {
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> findUser(String id);
  Future<List<UserModel>> findUsersByType(String type);
  Future<UserModel> updateUser(String id, UserModel user);
  Future<UserModel> removeUser(String id);
}

class UserDatasourceImp implements UserDatasource {
  final ApiService apiService;

  UserDatasourceImp({required this.apiService});

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await apiService.post('users', data: user.toJson());
    return UserModel.fromJson(response['data']);
  }

  @override
  Future<UserModel> findUser(String id) async {
    final response = await apiService.get('users/$id');
    return UserModel.fromJson(response['data']);
  }

  @override
  Future<List<UserModel>> findUsersByType(String type) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> removeUser(String id) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateUser(String id, User user) {
    throw UnimplementedError();
  }
}
