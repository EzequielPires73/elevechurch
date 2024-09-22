import 'package:flutter/material.dart';

class LivesPage extends StatefulWidget {
  const LivesPage({super.key});

  @override
  State<LivesPage> createState() => _LivesPageState();
}

class _LivesPageState extends State<LivesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ao vivo',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
