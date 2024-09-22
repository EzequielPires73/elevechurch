import 'package:flutter/material.dart';

class PastoralAgendaPage extends StatefulWidget {
  const PastoralAgendaPage({super.key});

  @override
  State<PastoralAgendaPage> createState() => _PastoralAgendaPageState();
}

class _PastoralAgendaPageState extends State<PastoralAgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agenda Pastoral',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
