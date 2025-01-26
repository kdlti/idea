import 'package:flutter/material.dart';

class IdeFutureLoading extends StatelessWidget {
  final double height;

  const IdeFutureLoading({super.key, this.height = 200});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          Text('Loading...', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
