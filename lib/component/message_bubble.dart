import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  const Bubble({super.key, required this.message, required this.isSender});
  final String message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: message,
      isSender: isSender,
      color: const Color(0xFF1B97F3),
      tail: true,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
