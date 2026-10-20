import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            key: const Key('success_screen'),
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: Colors.green, size: 90),
              const SizedBox(height: 16),
              const Text(
                'Замовлення успішно оформлено!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Дякуємо за покупку!',
                  textAlign: TextAlign.center),
              const SizedBox(height: 22),
              FilledButton(
                key: const Key('back_to_store'),
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Повернутися до магазину'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
