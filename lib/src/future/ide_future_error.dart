import 'package:flutter/material.dart';

class IdeFutureError extends StatelessWidget {
  final double height;
  final String error;

  const IdeFutureError({super.key, this.height = 200, required this.error});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: 500,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error, size: 40),
          Text('Ocorreu um erro na operação.', style: theme.textTheme.bodyMedium),
          Text(error.toString(), style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
