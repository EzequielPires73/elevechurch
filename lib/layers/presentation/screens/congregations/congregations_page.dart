import 'package:flutter/material.dart';

class CongregationsPage extends StatefulWidget {
  const CongregationsPage({super.key});

  @override
  State<CongregationsPage> createState() => _CongregationsPageState();
}

class _CongregationsPageState extends State<CongregationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Congregações',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
