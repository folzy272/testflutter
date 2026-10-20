import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/widgets/product_card.dart';

void main() {
  const discounted = Product(
    id: 'demo',
    name: 'Тестовий товар',
    price: 1000,
    discountPercent: 20,
    rating: 4.5,
    inStock: true,
    icon: Icons.devices,
  );

  Widget buildCard(Product product, VoidCallback onAdd) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 300,
          height: 350,
          child: ProductCard(product: product, onAddToCart: onAdd),
        ),
      ),
    );
  }

  group('ProductCard', () {
    testWidgets('1. Відображає ціну зі знижкою та закреслену стару',
        (tester) async {
      await tester.pumpWidget(buildCard(discounted, () {}));

      expect(find.text('1000 грн'), findsOneWidget);
      expect(find.textContaining('800 грн'), findsOneWidget);
      final original = tester.widget<Text>(
        find.byKey(const Key('original_price_demo')),
      );
      expect(original.style?.decoration, TextDecoration.lineThrough);
    });

    testWidgets('2. Кнопка додавання викликає callback', (tester) async {
      var clicks = 0;
      await tester.pumpWidget(buildCard(discounted, () => clicks++));

      await tester.tap(find.byKey(const Key('add_demo')));
      await tester.pump();

      expect(clicks, 1);
    });

    testWidgets('3. Відсутній товар має неактивну кнопку', (tester) async {
      const unavailable = Product(
        id: 'demo',
        name: 'Недоступний товар',
        price: 500,
        rating: 3.0,
        inStock: false,
        icon: Icons.devices,
      );
      await tester.pumpWidget(buildCard(unavailable, () {}));

      final button = tester.widget<ElevatedButton>(
        find.byKey(const Key('add_demo')),
      );
      expect(button.onPressed, isNull);
      expect(find.text('Немає в наявності'), findsOneWidget);
    });

    testWidgets('4. Рейтинг 4.5 показує 4 зірки та половину',
        (tester) async {
      await tester.pumpWidget(buildCard(discounted, () {}));

      expect(find.byIcon(Icons.star), findsNWidgets(4));
      expect(find.byIcon(Icons.star_half), findsOneWidget);
      expect(find.byIcon(Icons.star_border), findsNothing);
    });

    testWidgets('5. Без знижки немає старої ціни', (tester) async {
      const withoutDiscount = Product(
        id: 'demo',
        name: 'Звичайний товар',
        price: 500,
        rating: 3.0,
        inStock: true,
        icon: Icons.devices,
      );
      await tester.pumpWidget(buildCard(withoutDiscount, () {}));

      expect(find.text('500 грн'), findsOneWidget);
      expect(find.byKey(const Key('original_price_demo')), findsNothing);
      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
    });
  });
}
