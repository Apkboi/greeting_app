import 'package:flutter/material.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({Key? key, required this.greeting}) : super(key: key);
  final String greeting;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        greeting,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
