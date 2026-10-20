import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.remove_shopping_cart_outlined,
              color: Theme.of(context).colorScheme.primary, size: 72),
          const SizedBox(height: 12),
          const Text(
            'Кошик порожній',
            key: Key('empty_cart_message'),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Додайте товари, щоб оформити замовлення.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('До магазину'),
          ),
        ],
      ),
    );
  }
}
