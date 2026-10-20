import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:online_store/app.dart';
import 'package:online_store/state/cart_model.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Повний шлях: каталог → кошик → кількість → форма → успіх',
      (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartModel(),
        child: const OnlineStoreApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Відкриваємо магазин.
    expect(find.text('Каталог товарів'), findsOneWidget);

    // 2. Додаємо товар.
    await tester.ensureVisible(find.byKey(const Key('add_laptop')));
    await tester.tap(find.byKey(const Key('add_laptop')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('cart_badge_count')), findsOneWidget);

    // 3. Переходимо у кошик.
    await tester.tap(find.byKey(const Key('open_cart')));
    await tester.pumpAndSettle();
    expect(find.text('Ноутбук Pro 14'), findsOneWidget);

    // 4. Збільшуємо кількість до двох.
    await tester.tap(find.byKey(const Key('increase_laptop')));
    await tester.pumpAndSettle();
    expect(find.text('Разом: 57600 грн'), findsOneWidget);

    // 5. Переходимо до форми замовлення.
    await tester.tap(find.byKey(const Key('go_checkout')));
    await tester.pumpAndSettle();
    expect(find.text('Дані покупця'), findsOneWidget);

    // 6. Заповнюємо форму валідними даними.
    await tester.enterText(
        find.byKey(const Key('checkout_name')), 'Олена Петренко');
    await tester.enterText(
        find.byKey(const Key('checkout_phone')), '+380671234567');
    await tester.enterText(find.byKey(const Key('checkout_address')),
        'Київ, вул. Центральна, 15');
    await tester.pumpAndSettle();

    // 7. Підтверджуємо замовлення.
    await tester.ensureVisible(find.byKey(const Key('place_order')));
    await tester.tap(find.byKey(const Key('place_order')));
    await tester.pumpAndSettle();

    // 8. Перевіряємо екран успіху.
    expect(find.byKey(const Key('success_screen')), findsOneWidget);
    expect(find.text('Замовлення успішно оформлено!'), findsOneWidget);
  });
}
