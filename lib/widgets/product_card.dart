import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/format_price.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  final Product product;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      key: Key('product_card_${product.id}'),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(product.icon, size: 62, color: colors.primary),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                ...List.generate(5, (index) {
                  final difference = product.rating - index;
                  final star = difference >= 1
                      ? Icons.star
                      : difference >= 0.5
                          ? Icons.star_half
                          : Icons.star_border;
                  return Icon(star, size: 16, color: Colors.amber.shade700);
                }),
                const SizedBox(width: 4),
                Text(product.rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            if (product.hasDiscount) ...[
              Text(
                formatPrice(product.price),
                key: Key('original_price_${product.id}'),
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12,
                ),
              ),
              Text(
                '${formatPrice(product.finalPrice)}  −${product.discountPercent}%',
                key: Key('discounted_price_${product.id}'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ] else
              Text(
                formatPrice(product.price),
                key: Key('regular_price_${product.id}'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            const Spacer(),
            if (!product.inStock)
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text('Немає в наявності',
                    style: TextStyle(color: Colors.redAccent, fontSize: 12)),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                key: Key('add_${product.id}'),
                onPressed: product.inStock ? onAddToCart : null,
                icon: const Icon(Icons.add_shopping_cart, size: 18),
                label: const Text('До кошика'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
