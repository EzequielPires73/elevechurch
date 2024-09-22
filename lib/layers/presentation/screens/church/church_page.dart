import 'package:flutter/material.dart';

class ChurchPage extends StatefulWidget {
  const ChurchPage({super.key});

  @override
  State<ChurchPage> createState() => _ChurchPageState();
}

class _ChurchPageState extends State<ChurchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre a Igreja',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
