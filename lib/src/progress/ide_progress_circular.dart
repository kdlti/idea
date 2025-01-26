import 'package:flutter/material.dart';

class IdeProgressCircular extends StatelessWidget {
  final double? value;
  final double size;

  const IdeProgressCircular({super.key, this.value, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: 2,
          backgroundColor: Colors.black12,
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
