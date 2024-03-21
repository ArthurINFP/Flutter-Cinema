import 'package:cinema/Screen/about_screen.dart';
import 'package:cinema/Screen/login_screen.dart';
import 'package:cinema/themes/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      darkTheme: darkTheme,
      home: const LoginScreen(),
    );
  }
}
