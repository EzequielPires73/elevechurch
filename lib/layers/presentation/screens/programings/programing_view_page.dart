import 'package:elevechurch/layers/domain/entities/program.dart';
import 'package:flutter/material.dart';

class ProgramingViewPage extends StatelessWidget {
  final Program program;
  const ProgramingViewPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Programações',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              program.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Descrição
            if (program.description != null)
              Text(
                program.description!,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            // Status ativo ou inativo
            Row(
              children: [
                const Icon(Icons.circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(program.active ?? false ? 'Ativo' : 'Inativo'),
              ],
            ),
            const SizedBox(height: 16),
            // Horário
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(_getProgrammingDayTime(program)),
              ],
            ),
            const SizedBox(height: 16),
            // Notificação push
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.notifications),
                const SizedBox(width: 8),
                Text(program.pushNotification ?? false
                    ? 'Notificações ativadas'
                    : 'Notificações desativadas'),
              ],
            ),
            const SizedBox(height: 16),
            // Transmissão ao vivo
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.live_tv),
                const SizedBox(width: 8),
                Text(program.live ?? false
                    ? 'Será transmitido ao vivo'
                    : 'Sem transmissão ao vivo'),
              ],
            ),
            // Exibe imagem se houver
            if (program.image != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    program.image!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getProgrammingDayTime(Program program) {
    if (program.sunday != null) return 'Domingo às ${program.sunday}';
    if (program.thursday != null) return 'Quinta-feira às ${program.thursday}';
    return 'Horário não definido';
  }
}
