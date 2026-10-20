import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_store/app.dart';
import 'package:online_store/state/cart_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('19. Застосунок відкриває каталог товарів', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartModel(),
        child: const OnlineStoreApp(),
      ),
    );
    expect(find.text('Каталог товарів'), findsOneWidget);
    expect(find.byKey(const Key('open_cart')), findsOneWidget);
  });
}
