import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/cart_model.dart';
import '../utils/format_price.dart';
import '../widgets/empty_cart_widget.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Кошик')),
      body: cart.isEmpty
          ? const EmptyCartWidget()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      final product = item.product;
                      return Card(
                        key: Key('cart_item_${product.id}'),
                        margin: const EdgeInsets.only(bottom: 12),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(product.icon, size: 36),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(product.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  IconButton(
                                    key: Key('remove_${product.id}'),
                                    tooltip: 'Видалити товар',
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () => cart.remove(product.id),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text('Ціна: ${formatPrice(product.finalPrice)}'),
                              Row(
                                children: [
                                  IconButton(
                                    key: Key('decrease_${product.id}'),
                                    tooltip: 'Зменшити кількість',
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: item.quantity > 1
                                        ? () => cart.decrease(product.id)
                                        : null,
                                  ),
                                  Text('${item.quantity}',
                                      key: Key('quantity_${product.id}'),
                                      style: const TextStyle(fontSize: 18)),
                                  IconButton(
                                    key: Key('increase_${product.id}'),
                                    tooltip: 'Збільшити кількість',
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () => cart.increase(product.id),
                                  ),
                                  const Spacer(),
                                  Flexible(
                                    child: Text(
                                      'Сума: ${formatPrice(item.subtotal)}',
                                      key: Key('line_total_${product.id}'),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Разом: ${formatPrice(cart.total)}',
                          key: const Key('cart_total'),
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        FilledButton(
                          key: const Key('go_checkout'),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (_) => const CheckoutScreen()),
                          ),
                          child: const Text('Оформити замовлення'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
