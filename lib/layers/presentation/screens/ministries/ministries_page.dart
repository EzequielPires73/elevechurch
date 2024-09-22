import 'package:flutter/material.dart';

class MinistriesPage extends StatefulWidget {
  const MinistriesPage({super.key});

  @override
  State<MinistriesPage> createState() => _MinistriesPageState();
}

class _MinistriesPageState extends State<MinistriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ministérios',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
