import 'package:elevechurch/core/helpers/date.dart';
import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/data/repositories/prayer_repository_imp.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_state.dart';
import 'package:elevechurch/layers/presentation/screens/prayers/create_prayer_page.dart';
import 'package:elevechurch/layers/presentation/widgets/cards/card_prayer_comment.dart';
import 'package:elevechurch/layers/presentation/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewPrayerPage extends StatefulWidget {
  final Prayer prayer;
  const ViewPrayerPage({super.key, required this.prayer});

  @override
  State<ViewPrayerPage> createState() => _ViewPrayerPageState();
}

class _ViewPrayerPageState extends State<ViewPrayerPage> {
  late final User? user;
  late Prayer prayer;
  final TextEditingController message = TextEditingController();
  bool isPraying = false;
  bool isMyPraying = false;
  bool isLoading = false;

  @override
  void initState() {
    user = context.read<AuthBloc>().state.user;
    prayer = widget.prayer;
    isPraying = verifyPraying(widget.prayer);
    isMyPraying = widget.prayer.user?.id == user?.id;
    super.initState();
  }

  Future<void> changePraying() async {
    setState(() {
      isLoading = true;
    });
    context.read<PrayerBloc>().add(
          ChangePrayingEvent(
            id: widget.prayer.id!,
            viewPrayer: true,
          ),
        );
  }

  bool verifyPraying(prayer) {
    return prayer.praying
            ?.firstWhere(
              (e) => e.id == user?.id,
              orElse: () => UserModel(id: 0, name: '', email: ''),
            )
            .id ==
        user?.id;
  }

  commentPrayer() async {
    if (message.text != '' && prayer.id != null) {
      context
          .read<PrayerBloc>()
          .add(CreatePrayerCommentEvent(id: prayer.id!, message: message.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Detalhes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: isMyPraying
            ? [
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreatePrayerPage(),
                        )),
                    icon: const Icon(Icons.edit_outlined)),
                IconButton(
                    onPressed: () => _showConfirmDialog(context, 'Remover'),
                    icon: const Icon(Icons.delete_outline)),
              ]
            : [
                IconButton(
                    onPressed: () => _showConfirmDialog(context, 'Reportar'),
                    icon: const Icon(Icons.report_outlined)),
              ],
      ),
      body: BlocListener<PrayerBloc, PrayerState>(
        listener: (context, state) {
          if (state is PrayerFoundState) {
            setState(() {
              prayer = state.prayer;
              message.text = '';
              isPraying = verifyPraying(state.prayer);
              isLoading = false;
            });
          }
        },
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.indigo.shade100,
                ),
                child: Text(
                  reasonOptions
                      .firstWhere((e) => e.enumValue == prayer.reason)
                      .name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.indigo, width: 2)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: prayer.user?.avatar != null
                          ? Image.network(
                              prayer.user!.avatar!,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Icon(Icons.person_outline),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  prayer.user != null
                      ? Text(
                          prayer.user?.name ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                prayer.description,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    prayer.createdAt != null
                        ? formatFullDate(prayer.createdAt!)
                        : '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.amber.shade600 : Colors.black87,
                    ),
                  ),
                  isPraying
                      ? FilledButton.icon(
                          onPressed: isLoading ? null : changePraying,
                          icon: const Icon(Icons.favorite),
                          label: Text(
                            isLoading ? 'Atualizando...' : 'Orando',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: isLoading ? null : changePraying,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_border_outlined,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                isLoading ? 'Atualizando...' : 'Orar',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Comentários',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: prayer.comments != null && prayer.comments!.isNotEmpty
                    ? prayer.comments!
                        .map((e) => CardPrayerComment(
                              comment: e,
                              prayerId: prayer.id!,
                              userId: user?.id,
                            ))
                        .toList()
                    : [const NotFound(text: 'Nenhum comentário encontrado.')],
              )
            ],
          ),
        ),
      ),
      bottomSheet: BlocBuilder<PrayerBloc, PrayerState>(
        builder: (context, state) {
          return SafeArea(
            bottom: true,
            child: BottomAppBar(
              elevation: 8,
              shadowColor: Colors.black87,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: message,
                      decoration: const InputDecoration(
                        hintText: 'Adicione um comentário',
                      ),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 54,
                    height: 54,
                    child: IconButton.filled(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.indigo),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)))),
                      onPressed: commentPrayer,
                      icon: state is PrayerLoadingState
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.send_outlined,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$action pedido de oração',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          content: Text('Você tem certeza que deseja $action?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
                // Lógica para remover ou reportar
                if (action == 'Remover') {
                  // Coloque a lógica de reportar aqui
                } else if (action == 'Reportar') {
                  // Coloque a lógica de reportar aqui
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
