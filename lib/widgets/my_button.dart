import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const MyButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(label),
    );
  }
}
