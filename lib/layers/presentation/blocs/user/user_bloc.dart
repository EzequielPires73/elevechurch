import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/domain/usecases/user/create_user.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_event.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUser createUser;

  UserBloc({required this.createUser}) : super(UserInitialState()) {
    on<CreateUserEvent>(_onCreateUserEvent);
    on<FindUserEvent>(_onFindUserEvent);
  }

  Future<void> _onCreateUserEvent(
    CreateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      User user = await createUser.call(event.user);
      emit(UserCreatedState(user: user));
    } catch (e) {
      emit(UserOperationFailureState(error: e.toString()));
    }
  }

  Future<void> _onFindUserEvent(
    FindUserEvent event,
    Emitter<UserState> emit,
  ) async {}
}
