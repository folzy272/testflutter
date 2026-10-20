import 'package:flutter/material.dart';

import 'screens/shop_screen.dart';

class OnlineStoreApp extends StatelessWidget {
  const OnlineStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Онлайн-магазин',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2857AB)),
        scaffoldBackgroundColor: const Color(0xFFF7F8FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1D2940),
        ),
      ),
      home: const ShopScreen(),
    );
  }
}
