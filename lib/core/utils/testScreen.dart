import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  static const String screenName = '/test';
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 300,
        height: 300,
        color: Colors.red,
      ),
    );
  }
}
