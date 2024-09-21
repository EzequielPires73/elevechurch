import 'package:flutter/material.dart';

class CreatedUserSuccessPage extends StatelessWidget {
  const CreatedUserSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/illustrations/success.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text("Conta Criada com Sucesso",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Sua conta foi criada com sucesso! Bem-vindo(a) ao nosso aplicativo.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 56,
            height: 56,
            child: IconButton.filled(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
