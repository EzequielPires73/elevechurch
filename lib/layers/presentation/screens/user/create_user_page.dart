import 'package:elevechurch/core/helpers/mask.dart';
import 'package:elevechurch/core/helpers/validator.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_event.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_state.dart';
import 'package:elevechurch/layers/presentation/screens/user/created_user_success_page.dart';
import 'package:elevechurch/layers/presentation/widgets/button_primary.dart';
import 'package:elevechurch/layers/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateUserPage extends StatefulWidget {
  final User? user;
  const CreateUserPage({super.key, this.user});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cpf = TextEditingController();
  bool validatorEnabled = false;

  Future<void> _submit() async {
    if (formKey.currentState!.validate()) {
      final user = User(
        name: name.text,
        email: email.text,
        cpf: cpf.text,
        phone: phone.text,
        password: password.text,
      );

      if (widget.user == null) {
        context.read<UserBloc>().add(CreateUserEvent(user: user));
      }
    } else {
      setState(() {
        validatorEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fields = [
      CustomTextField(
        controller: name,
        label: 'Nome',
        hintText: 'Insira seu nome completo',
        validator: fieldRequired,
        validatorEnabled: validatorEnabled,
      ),
      CustomTextField(
        controller: cpf,
        label: 'CPF',
        hintText: 'Insira seu CPF',
        inputFormatters: [cpfFormatter],
        validator: fieldRequired,
        validatorEnabled: validatorEnabled,
      ),
      CustomTextField(
        controller: phone,
        label: 'Telefone',
        hintText: 'Insira seu telefone',
        inputFormatters: [phoneFormatter],
        validator: fieldRequired,
        validatorEnabled: validatorEnabled,
      ),
      CustomTextField(
        controller: email,
        label: 'Email',
        hintText: 'Insira seu email',
        validator: emailValidator,
        validatorEnabled: validatorEnabled,
      ),
      CustomTextField(
        controller: password,
        label: 'Senha',
        hintText: 'Insira sua senha',
        obscureText: true,
        validator: fieldRequired,
        validatorEnabled: validatorEnabled,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar conta',
          style: TextStyle(fontSize: 18),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserCreatedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const CreatedUserSuccessPage(),
              ),
            );
          } else if (state is UserOperationFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro: ${state.error}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 72),
              child: Column(
                children: List.generate(
                  fields.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: fields[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => BottomAppBar(
          color: Colors.white,
          child: ButtonPrimary(onPressed: _submit, title: 'Cadastrar'),
        ),
      ),
    );
  }
}
