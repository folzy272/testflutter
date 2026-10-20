import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/cart_model.dart';
import '../widgets/checkout_form.dart';
import 'success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оформлення замовлення')),
      body: CheckoutForm(
        onPlaceOrder: () {
          context.read<CartModel>().clear();
          Navigator.of(context).pushAndRemoveUntil<void>(
            MaterialPageRoute<void>(builder: (_) => const SuccessScreen()),
            (route) => route.isFirst,
          );
        },
      ),
    );
  }
}
