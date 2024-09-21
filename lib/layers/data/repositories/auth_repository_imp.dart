import 'package:elevechurch/core/error/exeptions.dart';
import 'package:elevechurch/core/error/failure.dart';
import 'package:elevechurch/layers/data/datasources/auth_datasource.dart';
import 'package:elevechurch/layers/domain/entities/auth_response.dart';
import 'package:elevechurch/layers/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImp({required this.datasource});

  @override
  Future<bool> isSignedIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    try {
      return await datasource.signIn(email, password);
    } on ServerException catch (e) {
      throw ServerFailure(
          message: e.message == 'Unauthorized'
              ? 'Crendenciais inválidas'
              : e.message);
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
