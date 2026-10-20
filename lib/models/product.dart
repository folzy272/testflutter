import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.inStock,
    required this.icon,
    this.discountPercent = 0,
  });

  final String id;
  final String name;
  final double price;
  final int discountPercent;
  final double rating;
  final bool inStock;
  final IconData icon;

  double get finalPrice => price * (100 - discountPercent) / 100;
  bool get hasDiscount => discountPercent > 0;
}
