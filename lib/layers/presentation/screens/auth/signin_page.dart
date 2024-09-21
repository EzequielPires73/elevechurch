import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_event.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_state.dart';
import 'package:elevechurch/layers/presentation/screens/user/create_user_page.dart';
import 'package:elevechurch/layers/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  _submit() {
    context.read<AuthBloc>().add(
          AuthSignin(
            email: email.text,
            password: password.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro: ${state.error}')),
            );
          } else if (state is AuthenticatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User: ${state.user?.name}')),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                'https://portalwp.s3.amazonaws.com/wp-content/uploads/2023/06/12165840/Oracao-3.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0, -24, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Entre na sua conta',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      hintText: 'Insira sua senha',
                      hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: const Text('Senha'),
                      hintText: 'Insira sua senha',
                      hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Esqueceu sua senha?'),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) => ButtonPrimary(
                      onPressed:
                          state is AuthenticationLoading ? null : _submit,
                      title: 'Entrar',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Center(
                    child: Text('ou'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateUserPage(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: const Text('Criar sua conta'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
