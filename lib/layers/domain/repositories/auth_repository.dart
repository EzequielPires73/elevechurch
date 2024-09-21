import 'package:elevechurch/layers/domain/entities/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> signIn(String email, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();
}
