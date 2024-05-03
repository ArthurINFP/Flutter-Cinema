import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldSearch(
              label: "Search Movie",
              controller: _controller,
              minStringLength: 3,
              decoration: const InputDecoration(hintText: "E.g The Pianist"),
            )
          ],
        ),
      ),
    );
  }
}
