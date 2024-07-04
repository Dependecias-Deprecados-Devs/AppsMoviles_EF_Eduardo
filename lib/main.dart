import 'package:flutter/material.dart';
import 'package:my_super_cat_app/widgets/bottom_navbar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavbar()
    );
  }
}