import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_store/widgets/checkout_form.dart';

void main() {
  Widget buildForm(VoidCallback onPlaceOrder) {
    return MaterialApp(
      home: Scaffold(body: CheckoutForm(onPlaceOrder: onPlaceOrder)),
    );
  }

  Future<void> fillValidForm(WidgetTester tester) async {
    await tester.enterText(
        find.byKey(const Key('checkout_name')), 'Олена Петренко');
    await tester.enterText(
        find.byKey(const Key('checkout_phone')), '+380671234567');
    await tester.enterText(find.byKey(const Key('checkout_address')),
        'Київ, вул. Центральна, 15');
    await tester.pump();
  }

  group('CheckoutForm', () {
    testWidgets('13. Усі три поля обов’язкові', (tester) async {
      await tester.pumpWidget(buildForm(() {}));

      final form = tester.state<FormState>(find.byType(Form));
      expect(form.validate(), isFalse);
      await tester.pump();

      expect(find.text('Вкажіть ім’я'), findsOneWidget);
      expect(find.text('Вкажіть телефон'), findsOneWidget);
      expect(find.text('Вкажіть адресу'), findsOneWidget);
    });

    testWidgets('14. Неправильний телефон не проходить валідацію',
        (tester) async {
      await tester.pumpWidget(buildForm(() {}));
      await tester.enterText(
          find.byKey(const Key('checkout_name')), 'Олена Петренко');
      await tester.enterText(
          find.byKey(const Key('checkout_phone')), '123ABC');
      await tester.enterText(find.byKey(const Key('checkout_address')),
          'Київ, вул. Центральна, 15');
      await tester.pump();

      expect(find.text('Неправильний формат телефону'), findsOneWidget);
      final button = tester.widget<FilledButton>(
          find.byKey(const Key('place_order')));
      expect(button.onPressed, isNull);
    });

    testWidgets('15. Адреса коротша 10 символів не проходить перевірку',
        (tester) async {
      await tester.pumpWidget(buildForm(() {}));
      await tester.enterText(
          find.byKey(const Key('checkout_address')), 'Київ 1');
      await tester.pump();

      expect(find.text('Адреса має містити мінімум 10 символів'),
          findsOneWidget);
    });

    testWidgets('16. Кнопка замовлення вимкнена при неповній формі',
        (tester) async {
      await tester.pumpWidget(buildForm(() {}));
      await tester.enterText(
          find.byKey(const Key('checkout_name')), 'Олена');
      await tester.pump();

      final button = tester.widget<FilledButton>(
          find.byKey(const Key('place_order')));
      expect(button.onPressed, isNull);
    });

    testWidgets('17. Валідна форма активує кнопку та викликає callback',
        (tester) async {
      var orders = 0;
      await tester.pumpWidget(buildForm(() => orders++));
      await fillValidForm(tester);

      final button = tester.widget<FilledButton>(
          find.byKey(const Key('place_order')));
      expect(button.onPressed, isNotNull);
      await tester.ensureVisible(find.byKey(const Key('place_order')));
      await tester.tap(find.byKey(const Key('place_order')));
      await tester.pump();
      expect(orders, 1);
    });

    testWidgets('18. Порожнє ім’я блокує оформлення', (tester) async {
      await tester.pumpWidget(buildForm(() {}));
      await fillValidForm(tester);
      await tester.enterText(find.byKey(const Key('checkout_name')), '   ');
      await tester.pump();

      final button = tester.widget<FilledButton>(
          find.byKey(const Key('place_order')));
      expect(button.onPressed, isNull);
    });
  });
}
