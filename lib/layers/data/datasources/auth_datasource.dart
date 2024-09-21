import 'dart:convert';

import 'package:elevechurch/core/error/exeptions.dart';
import 'package:elevechurch/core/network/api_service.dart';
import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/domain/entities/auth_response.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDatasource {
  Future<AuthResponse> signIn(String email, String password);
  Future<void> signOut();
}

class AuthDatasourceImp implements AuthDatasource {
  final ApiService apiService;

  AuthDatasourceImp({required this.apiService});

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    var response = await apiService.post('auth/login/members',
        data: {'email': email, 'password': password});

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = UserModel.fromJson(response['user']);
    prefs.setString('user', jsonEncode(user));
    prefs.setString('access_token', response['access_token']);

    return AuthResponse(
      token: response['access_token'],
      user: user,
    );
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
