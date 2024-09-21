import 'package:elevechurch/layers/domain/entities/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> signIn(String email, String password);
  Future<AuthResponse?> loadUser();
  Future<void> signOut();
  Future<bool> isSignedIn();
}
