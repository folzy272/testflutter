import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_store/data/products.dart';
import 'package:online_store/screens/cart_screen.dart';
import 'package:online_store/state/cart_model.dart';
import 'package:online_store/widgets/empty_cart_widget.dart';
import 'package:provider/provider.dart';

void main() {
  Widget buildCart(CartModel cart) {
    return ChangeNotifierProvider<CartModel>.value(
      value: cart,
      child: const MaterialApp(home: CartScreen()),
    );
  }

  group('CartScreen', () {
    testWidgets('6. Відображає товар, його кількість та суму',
        (tester) async {
      final cart = CartModel()..add(catalog[0]);
      await tester.pumpWidget(buildCart(cart));

      expect(find.text('Ноутбук Pro 14'), findsOneWidget);
      expect(find.byKey(const Key('quantity_laptop')), findsOneWidget);
      expect(find.text('Сума: 28800 грн'), findsOneWidget);
    });

    testWidgets('7. Плюс збільшує кількість', (tester) async {
      final cart = CartModel()..add(catalog[0]);
      await tester.pumpWidget(buildCart(cart));

      await tester.tap(find.byKey(const Key('increase_laptop')));
      await tester.pump();

      expect(cart.quantityOf('laptop'), 2);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('8. Мінус не дозволяє зменшити кількість нижче 1',
        (tester) async {
      final cart = CartModel()..add(catalog[0]);
      await tester.pumpWidget(buildCart(cart));

      final decrease = tester.widget<IconButton>(
        find.byKey(const Key('decrease_laptop')),
      );
      expect(decrease.onPressed, isNull);
      expect(cart.quantityOf('laptop'), 1);
    });

    testWidgets('9. Загальна сума змінюється разом із кількістю',
        (tester) async {
      final cart = CartModel()..add(catalog[0]);
      await tester.pumpWidget(buildCart(cart));

      expect(find.text('Разом: 28800 грн'), findsOneWidget);
      await tester.tap(find.byKey(const Key('increase_laptop')));
      await tester.pump();
      expect(find.text('Разом: 57600 грн'), findsOneWidget);

      await tester.tap(find.byKey(const Key('decrease_laptop')));
      await tester.pump();
      expect(find.text('Разом: 28800 грн'), findsOneWidget);
    });

    testWidgets('10. Порожній кошик показує EmptyCartWidget',
        (tester) async {
      await tester.pumpWidget(buildCart(CartModel()));

      expect(find.byType(EmptyCartWidget), findsOneWidget);
      expect(find.text('Кошик порожній'), findsOneWidget);
      expect(find.byKey(const Key('go_checkout')), findsNothing);
    });

    testWidgets('11. Видалення останнього товару повертає порожній кошик',
        (tester) async {
      final cart = CartModel()..add(catalog[0]);
      await tester.pumpWidget(buildCart(cart));

      await tester.tap(find.byKey(const Key('remove_laptop')));
      await tester.pump();

      expect(cart.isEmpty, isTrue);
      expect(find.byType(EmptyCartWidget), findsOneWidget);
    });

    testWidgets('12. Сума містить усі різні товари', (tester) async {
      final cart = CartModel()
        ..add(catalog[0])
        ..add(catalog[1]);
      await tester.pumpWidget(buildCart(cart));

      expect(find.text('Ноутбук Pro 14'), findsOneWidget);
      expect(find.text('Бездротові навушники'), findsOneWidget);
      expect(find.text('Разом: 30720 грн'), findsOneWidget);
    });
  });
}
