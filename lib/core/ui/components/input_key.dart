import 'package:flutter/material.dart';

class InputKey extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onKeyPressed;

  const InputKey({
    super.key,
    required this.color,
    required this.child,
    required this.onKeyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: InkWell(
        onTap: onKeyPressed,
        child: Ink(
          color: color,
          child: Align(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}

class ValueInputKey extends StatelessWidget {
  final String label;
  final VoidCallback onKeyPressed;
  const ValueInputKey({super.key, required this.label, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputKey(
      color: colorScheme.surface,
      onKeyPressed: onKeyPressed,
      child: Text(label),
    );
  }
}

class IconInputKey extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onKeyPressed;
  const IconInputKey({super.key, required this.icon, required this.color, required this.bgColor, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return InputKey(
      color: bgColor,
      onKeyPressed: onKeyPressed,
      child: Icon(
        icon,
        size: 34.0,
        weight: 200,
        color: color,
      ),
    );
  }
}
