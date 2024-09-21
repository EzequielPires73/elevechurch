import 'package:get_it/get_it.dart';
import 'package:elevechurch/layers/data/datasources/user_datasource.dart';
import 'package:elevechurch/layers/data/datasources/auth_datasource.dart';
import 'package:elevechurch/layers/data/repositories/user_repository_imp.dart';
import 'package:elevechurch/layers/data/repositories/auth_repository_imp.dart';
import 'package:elevechurch/layers/domain/repositories/user_repository.dart';
import 'package:elevechurch/layers/domain/repositories/auth_repository.dart';
import 'package:elevechurch/layers/domain/usecases/user/create_user.dart';
import 'package:elevechurch/layers/domain/usecases/auth/signin.dart';
import 'package:elevechurch/layers/domain/usecases/auth/signout.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:elevechurch/core/network/api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Core
  sl.registerLazySingleton<ApiService>(
    () => ApiService(dio: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<UserDatasource>(
    () => UserDatasourceImp(apiService: sl()),
  );

  sl.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImp(apiService: sl()),
  );

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(datasource: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(datasource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<CreateUser>(
    () => CreateUser(repository: sl()),
  );

  sl.registerLazySingleton<SignIn>(
    () => SignIn(repository: sl()),
  );

  sl.registerLazySingleton<SignOut>(
    () => SignOut(repository: sl()),
  );

  // Blocs
  sl.registerFactory<UserBloc>(
    () => UserBloc(createUser: sl()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signIn: sl(),
      signout: sl(),
    ),
  );
}
