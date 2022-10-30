import 'package:flutter/material.dart';

class HyperLink extends StatelessWidget {
  const HyperLink(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
