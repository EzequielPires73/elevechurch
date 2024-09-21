import 'package:elevechurch/layers/domain/entities/auth_response.dart';
import 'package:elevechurch/layers/domain/usecases/auth/load_user.dart';
import 'package:elevechurch/layers/domain/usecases/auth/signin.dart';
import 'package:elevechurch/layers/domain/usecases/auth/signout.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_event.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignOut signout;
  final LoadUser loadUser;

  AuthBloc({
    required this.signIn,
    required this.signout,
    required this.loadUser,
  }) : super(AuthenticationInitial()) {
    on<AuthLoadUser>(_onAuthLoadUser);
    on<AuthSignin>(_onAuthSignin);
    on<AuthLogout>(_onAuthLogout);
  }

  Future<void> _onAuthLoadUser(
      AuthLoadUser event, Emitter<AuthState> emit) async {
    AuthResponse? response = await loadUser.call();

    if (response != null) {
      emit(AuthenticatedState(
        user: response.user,
        token: response.token,
      ));
    } else {
      emit(UnauthenticatedState());
    }
  }

  Future<void> _onAuthSignin(AuthSignin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthenticationLoading());

      AuthResponse response = await signIn.call(
        event.email,
        event.password,
      );

      emit(AuthenticatedState(user: response.user, token: response.token));
    } catch (e) {
      emit(AuthenticationFailure(error: e.toString()));
    }
  }

  Future<void> _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthenticationLoading());
    await signout.call();
    emit(UnauthenticatedState());
  }
}
