import 'package:elevechurch/injections.dart' as di;
import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_event.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_state.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_bloc.dart';
import 'package:elevechurch/layers/presentation/screens/auth/signin_page.dart';
import 'package:elevechurch/layers/presentation/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => di.sl<UserBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(AuthLoadUser()),
        ),
      ],
      child: MaterialApp(
          title: 'Eleve Church',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                shadowColor: Colors.black38,
                elevation: 4),
          ),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthenticatedState) {
                return const HomePage();
              } else if (state is UnauthenticatedState ||
                  state is AuthenticationFailure ||
                  state is AuthenticationLoading) {
                return const SigninPage();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
