import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;

  const BodyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }
}