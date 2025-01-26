import 'package:flutter/material.dart';

typedef IdeEnabledWidget = Widget Function();

/// De acordo com o status passado, cria um widget fornecido ou um widget desabilitado.
class IdeEnabled extends StatelessWidget {
  final IdeEnabledWidget child;
  final bool status;

  const IdeEnabled({super.key, required this.status, required this.child});

  @override
  Widget build(BuildContext context) {
    if (status) {
      return child();
    } else {
      return AbsorbPointer(
        absorbing: true,
        child: Opacity(
          opacity: 0.5,
          child: child(),
        ),
      );
    }
  }
}