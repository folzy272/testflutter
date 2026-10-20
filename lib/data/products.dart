import 'package:flutter/material.dart';

import '../models/product.dart';

const List<Product> catalog = [
  Product(
    id: 'laptop',
    name: 'Ноутбук Pro 14',
    price: 32000,
    discountPercent: 10,
    rating: 4.5,
    inStock: true,
    icon: Icons.laptop_mac,
  ),
  Product(
    id: 'headphones',
    name: 'Бездротові навушники',
    price: 2400,
    discountPercent: 20,
    rating: 4.0,
    inStock: true,
    icon: Icons.headphones,
  ),
  Product(
    id: 'keyboard',
    name: 'Механічна клавіатура',
    price: 1800,
    rating: 5.0,
    inStock: true,
    icon: Icons.keyboard,
  ),
  Product(
    id: 'mouse',
    name: 'Бездротова миша',
    price: 900,
    rating: 4.0,
    inStock: true,
    icon: Icons.mouse,
  ),
  Product(
    id: 'monitor',
    name: 'Монітор 27 дюймів',
    price: 7000,
    discountPercent: 5,
    rating: 4.5,
    inStock: true,
    icon: Icons.desktop_windows,
  ),
  Product(
    id: 'speaker',
    name: 'Портативна колонка',
    price: 1200,
    rating: 3.5,
    inStock: false,
    icon: Icons.speaker,
  ),
];
