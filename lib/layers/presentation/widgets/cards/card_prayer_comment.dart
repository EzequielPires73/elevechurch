import 'package:elevechurch/core/helpers/date.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPrayerComment extends StatelessWidget {
  final int prayerId;
  final int? userId;
  final PrayerComment comment;
  const CardPrayerComment(
      {super.key,
      required this.comment,
      required this.prayerId,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Card.filled(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: PopupMenuButton<String>(
              color: Colors.white,
              onSelected: (String result) {
                switch (result) {
                  case 'Remover':
                    _showConfirmDialog(context, 'Remover');
                    break;
                  case 'Reportar':
                    _showConfirmDialog(context, 'Reportar');
                    break;
                }
              },
              itemBuilder: (BuildContext context) => userId == comment.user?.id
                  ? [
                      const PopupMenuItem<String>(
                        value: 'Remover',
                        child: Text('Remover'),
                      ),
                    ]
                  : [
                      const PopupMenuItem<String>(
                        value: 'Reportar',
                        child: Text('Reportar'),
                      ),
                    ],
              icon: const Icon(Icons.more_vert_outlined),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black87, width: 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: comment.user?.avatar != null
                        ? Image.network(
                            comment.user!.avatar!,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.user?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        comment.content,
                        style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87),
                      ),
                      comment.createdAt != null
                          ? Text(
                              '${formatFullDate(comment.createdAt!)}  ${formatTimeByDate(comment.createdAt!)}',
                              style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black87,
                                fontSize: 12,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$action comentário',
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
                  context.read<PrayerBloc>().add(RemovePrayerCommentEvent(
                      commentId: comment.id!, prayerId: prayerId));
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
