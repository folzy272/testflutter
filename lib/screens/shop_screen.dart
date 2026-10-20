import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/products.dart';
import '../state/cart_model.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Онлайн-магазин'),
        actions: [
          IconButton(
            key: const Key('open_cart'),
            tooltip: 'Відкрити кошик',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const CartScreen()),
            ),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined, size: 28),
                if (cart.itemCount > 0)
                  Positioned(
                    top: -9,
                    right: -10,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.redAccent,
                      child: Text(
                        '${cart.itemCount}',
                        key: const Key('cart_badge_count'),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text('Каталог товарів',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.crossAxisExtent;
                // Одна колонка на телефоні, кілька на планшеті та ПК.
                final count =
                    width < 530 ? 1 : (width / 255).floor().clamp(2, 4).toInt();
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    mainAxisExtent: 400,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = catalog[index];
                      return ProductCard(
                        product: product,
                        onAddToCart: () {
                          context.read<CartModel>().add(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} додано до кошика'),
                              duration: const Duration(milliseconds: 800),
                            ),
                          );
                        },
                      );
                    },
                    childCount: catalog.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
