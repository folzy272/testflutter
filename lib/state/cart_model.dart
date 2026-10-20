import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  double get subtotal => product.finalPrice * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);
}

class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => List.unmodifiable(_items.values);
  bool get isEmpty => _items.isEmpty;
  int get itemCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);
  double get total =>
      _items.values.fold(0.0, (sum, item) => sum + item.subtotal);

  int quantityOf(String productId) => _items[productId]?.quantity ?? 0;

  void add(Product product) {
    if (!product.inStock) return;

    final existing = _items[product.id];
    _items[product.id] = CartItem(
      product: product,
      quantity: (existing?.quantity ?? 0) + 1,
    );
    notifyListeners();
  }

  void increase(String productId) {
    final item = _items[productId];
    if (item == null) return;
    _items[productId] = item.copyWith(quantity: item.quantity + 1);
    notifyListeners();
  }

  void decrease(String productId) {
    final item = _items[productId];
    if (item == null || item.quantity <= 1) return;
    _items[productId] = item.copyWith(quantity: item.quantity - 1);
    notifyListeners();
  }

  void remove(String productId) {
    if (_items.remove(productId) != null) notifyListeners();
  }

  void clear() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}
