import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({super.key, required this.label, required this.onTab});

  final String label;
  final Function() onTab;

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 25),
          ),
        ),
      ),
    );
  }
}
