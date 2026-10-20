import 'package:flutter/material.dart';

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({super.key, required this.onPlaceOrder});

  final VoidCallback onPlaceOrder;

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

  static final _phonePattern = RegExp(r'^\+?[0-9]{10,15}$');

  String _normalizedPhone(String input) =>
      input.replaceAll(RegExp(r'[\s()\-]'), '');

  bool get _isValid =>
      _name.text.trim().isNotEmpty &&
      _phonePattern.hasMatch(_normalizedPhone(_phone.text.trim())) &&
      _address.text.trim().length >= 10;

  @override
  void initState() {
    super.initState();
    _name.addListener(_updateButton);
    _phone.addListener(_updateButton);
    _address.addListener(_updateButton);
  }

  void _updateButton() => setState(() {});

  void _submit() {
    if (_formKey.currentState!.validate()) widget.onPlaceOrder();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Дані покупця',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            TextFormField(
              key: const Key('checkout_name'),
              controller: _name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ім’я та прізвище',
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Вкажіть ім’я'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('checkout_phone'),
              controller: _phone,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Телефон',
                hintText: '+380671234567',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Вкажіть телефон';
                }
                if (!_phonePattern.hasMatch(_normalizedPhone(value.trim()))) {
                  return 'Неправильний формат телефону';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('checkout_address'),
              controller: _address,
              textInputAction: TextInputAction.done,
              maxLines: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Адреса доставки',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Вкажіть адресу';
                }
                if (value.trim().length < 10) {
                  return 'Адреса має містити мінімум 10 символів';
                }
                return null;
              },
            ),
            const SizedBox(height: 22),
            FilledButton(
              key: const Key('place_order'),
              onPressed: _isValid ? _submit : null,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 11),
                child: Text('Підтвердити замовлення'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
