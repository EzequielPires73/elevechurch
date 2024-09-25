import 'package:elevechurch/core/helpers/validator.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_event.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_state.dart';
import 'package:elevechurch/layers/presentation/screens/user/create_user_page.dart';
import 'package:elevechurch/layers/presentation/widgets/button_primary.dart';
import 'package:elevechurch/layers/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool validatorEnabled = false;

  _submit() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignin(
              email: email.text,
              password: password.text,
            ),
          );
    } else {
      setState(() {
        validatorEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro: ${state.error}')),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 120,
              left: 16,
              right: 16,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 180,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Entre na sua conta',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: email,
                    label: 'Email',
                    hintText: 'Insira sua senha',
                    validator: fieldRequired,
                    validatorEnabled: validatorEnabled,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    controller: password,
                    label: 'Senha',
                    hintText: 'Insira sua senha',
                    obscureText: true,
                    validator: fieldRequired,
                    validatorEnabled: validatorEnabled,
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
          ),
        ),
      ),
    );
  }
}
