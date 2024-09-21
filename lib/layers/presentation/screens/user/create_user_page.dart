import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_event.dart';
import 'package:elevechurch/layers/presentation/blocs/user/user_state.dart';
import 'package:elevechurch/layers/presentation/screens/user/created_user_success_page.dart';
import 'package:elevechurch/layers/presentation/widgets/button_primary.dart';
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

  Future<void> _submit() async {
    if (formKey.currentState!.validate()) {
      final user = User(
        name: name.text,
        email: email.text,
        cpf: cpf.text,
        phone: phone.text,
      );

      if (widget.user == null) {
        context.read<UserBloc>().add(CreateUserEvent(user: user));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fields = [
      TextFormField(
        controller: name,
        decoration: const InputDecoration(
            label: Text('Nome'), hintText: 'Insira seu nome completo'),
      ),
      TextFormField(
        controller: cpf,
        decoration: const InputDecoration(
            label: Text('CPF'), hintText: 'Insira seu CPF'),
      ),
      TextFormField(
        controller: phone,
        decoration: const InputDecoration(
            label: Text('Telefone'), hintText: 'Insira seu telefone'),
      ),
      TextFormField(
        controller: email,
        decoration: const InputDecoration(
            label: Text('Email'), hintText: 'Insira seu email'),
      ),
      TextFormField(
        controller: password,
        obscureText: true,
        decoration: const InputDecoration(
            label: Text('Senha'), hintText: 'Insira sua senha'),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar conta',
          style: TextStyle(fontSize: 18),
        ),
      ),
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
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: ListView.separated(
              itemBuilder: (context, index) => fields[index],
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: fields.length,
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
