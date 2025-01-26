import 'package:flutter/material.dart';

class IdeProgressBar extends StatelessWidget {
  final double? value;
  final double height;

  const IdeProgressBar({super.key, this.value, this.height = 2});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      minHeight: height,
      backgroundColor: Colors.black12,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
    );
  }
}
