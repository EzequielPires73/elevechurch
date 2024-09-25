import "package:elevechurch/core/helpers/validator.dart";
import "package:elevechurch/layers/data/repositories/prayer_repository_imp.dart";
import "package:elevechurch/layers/domain/entities/prayer.dart";
import "package:elevechurch/layers/domain/entities/user.dart";
import "package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart";
import "package:elevechurch/layers/presentation/blocs/prayer/prayer_bloc.dart";
import "package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart";
import "package:elevechurch/layers/presentation/blocs/prayer/prayer_state.dart";
import "package:elevechurch/layers/presentation/widgets/button_primary.dart";
import "package:elevechurch/layers/presentation/widgets/custom_dropdown.dart";
import "package:elevechurch/layers/presentation/widgets/custom_text_field.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CreatePrayerPage extends StatefulWidget {
  const CreatePrayerPage({super.key});

  @override
  State<CreatePrayerPage> createState() => _CreatePrayerPageState();
}

class _CreatePrayerPageState extends State<CreatePrayerPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  ReasonOption? reason;
  bool receiveCall = true;
  bool receiveVisit = true;
  bool postOnWall = true;
  bool validatorEnabled = false;

  Future<void> _submit() async {
    if (formKey.currentState!.validate()) {
      User? user = context.read<AuthBloc>().state.user;
      print(user);
      final prayer = Prayer(
        description: description.text,
        reason: reason?.enumValue ?? '',
        receiveCall: receiveCall,
        receiveVisit: receiveVisit,
        postOnWall: postOnWall,
        user: user,
        active: true,
      );

      context.read<PrayerBloc>().add(CreatePrayerEvent(prayer: prayer));
    } else {
      setState(() {
        validatorEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fazer um pedido de oração',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<PrayerBloc, PrayerState>(
        listener: (context, state) {
          if (state is PrayerCreatedState) {
            Navigator.pop(context, 'Pedido de oração criado com sucesso.');
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  CustomDropdown(
                    controller: reasonController,
                    label: 'Motivo',
                    hintText: 'Selecione um motivo para o seu pedido',
                    dropdownMenuEntries: reasonOptions
                        .map((element) => DropdownMenuEntry(
                            value: element.id, label: element.name))
                        .toList(),
                    onSelected: (value) {
                      setState(() {
                        reason = reasonOptions.firstWhere((e) => e.id == value);
                      });
                    },
                    validator: (obj) => fieldRequired(obj?.toString()),
                    validatorEnabled: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    controller: description,
                    label: 'Descrição',
                    hintText: 'Insira o que gostaria de pedir',
                    validator: fieldRequired,
                    maxLines: 4,
                    validatorEnabled: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CheckboxListTile(
                    tristate: true,
                    value: true,
                    title: const Text('Receber a visita'),
                    onChanged: (value) {
                      setState(() {
                        receiveVisit = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    tristate: true,
                    value: true,
                    title: const Text('Receber uma ligação'),
                    onChanged: (value) {
                      setState(() {
                        receiveCall = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    tristate: true,
                    value: true,
                    title: const Text('Exibir o seu pedido no mural'),
                    onChanged: (value) {
                      setState(() {
                        postOnWall = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BottomAppBar(
        child: BlocBuilder<PrayerBloc, PrayerState>(
          builder: (context, state) => ButtonPrimary(
            onPressed: state is PrayerLoadingState ? null : _submit,
            title: 'Continuar',
          ),
        ),
      ),
    );
  }
}
