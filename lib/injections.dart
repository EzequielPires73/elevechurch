import 'package:elevechurch/layers/data/datasources/prayer_datasouce.dart';
import 'package:elevechurch/layers/data/repositories/prayer_repository_imp.dart';
import 'package:elevechurch/layers/domain/repositories/prayer_repository.dart';
import 'package:elevechurch/layers/domain/usecases/auth/load_user.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/change_praying.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/create_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_my_prayers.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayers.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_prayers_by_reason.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/find_praying.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/remove_prayer.dart';
import 'package:elevechurch/layers/domain/usecases/prayer/update_prayer.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_bloc.dart';
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

  sl.registerLazySingleton<PrayerDatasouce>(
    () => PrayerDatasouceImp(apiService: sl()),
  );

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(datasource: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(datasource: sl()),
  );

  sl.registerLazySingleton<PrayerRepository>(
    () => PrayerRepositoryImp(datasource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<CreateUser>(
    () => CreateUser(repository: sl()),
  );

  sl.registerLazySingleton<LoadUser>(
    () => LoadUser(repository: sl()),
  );

  sl.registerLazySingleton<SignIn>(
    () => SignIn(repository: sl()),
  );

  sl.registerLazySingleton<SignOut>(
    () => SignOut(repository: sl()),
  );

  sl.registerLazySingleton<CreatePrayer>(
    () => CreatePrayer(repository: sl()),
  );

  sl.registerLazySingleton<UpdatePrayer>(
    () => UpdatePrayer(repository: sl()),
  );

  sl.registerLazySingleton<RemovePrayer>(
    () => RemovePrayer(repository: sl()),
  );

  sl.registerLazySingleton<FindPrayer>(
    () => FindPrayer(repository: sl()),
  );

  sl.registerLazySingleton<FindPrayers>(
    () => FindPrayers(repository: sl()),
  );

  sl.registerLazySingleton<FindPrayersByReason>(
    () => FindPrayersByReason(repository: sl()),
  );

  sl.registerLazySingleton<FindMyPrayers>(
    () => FindMyPrayers(repository: sl()),
  );

  sl.registerLazySingleton<FindPraying>(
    () => FindPraying(repository: sl()),
  );

  sl.registerLazySingleton<ChangePraying>(
    () => ChangePraying(repository: sl()),
  );

  // Blocs
  sl.registerFactory<UserBloc>(
    () => UserBloc(createUser: sl()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loadUser: sl(),
      signIn: sl(),
      signout: sl(),
    ),
  );

  sl.registerLazySingleton<PrayerBloc>(() => PrayerBloc(
        createPrayer: sl(),
        updatePrayer: sl(),
        removePrayer: sl(),
        findPrayer: sl(),
        findPrayers: sl(),
        findPrayersByReason: sl(),
        findPraying: sl(),
        changePraying: sl(),
      ));
}
