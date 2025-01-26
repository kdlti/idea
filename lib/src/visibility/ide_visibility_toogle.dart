import 'package:flutter/material.dart';
import 'package:idea/src/visibility/ide_visibility_builder.dart';

/// De condição passada alterna entre os widgets fornecido.
class IdeVisibilityToggle extends StatelessWidget {
  final bool condition;
  final IdeVisibilityWidget firstChild;
  final IdeVisibilityWidget secondChild;

  const IdeVisibilityToggle({
    super.key,
    required this.condition,
    required this.firstChild,
    required this.secondChild,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? firstChild() : secondChild();
  }
}
