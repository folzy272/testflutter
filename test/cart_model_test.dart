import 'package:flutter_test/flutter_test.dart';
import 'package:online_store/data/products.dart';
import 'package:online_store/state/cart_model.dart';

void main() {
  group('CartModel (додаткові unit-тести)', () {
    test('Не додає товар, якого немає у продажу', () {
      final cart = CartModel();
      cart.add(catalog.last);
      expect(cart.isEmpty, isTrue);
    });

    test('Не допускає кількості менше одиниці', () {
      final cart = CartModel()..add(catalog.first);
      cart.decrease('laptop');
      expect(cart.quantityOf('laptop'), 1);
    });

    test('Після оформлення очищує кошик', () {
      final cart = CartModel()..add(catalog.first);
      cart.clear();
      expect(cart.isEmpty, isTrue);
      expect(cart.total, 0);
    });
  });
}
