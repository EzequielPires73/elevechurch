import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  final String? text;

  const NotFound({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(text ?? 'Nenhum resultado encontrado.'),
      ),
    );
  }
}
