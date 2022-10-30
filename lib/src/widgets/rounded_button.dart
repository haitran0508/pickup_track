import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.size = const Size.fromHeight(40),
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: size,
      ),
      child: Text(label),
    );
  }
}
