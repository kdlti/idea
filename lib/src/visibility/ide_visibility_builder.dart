import 'package:flutter/material.dart';

typedef IdeVisibilityWidget<Widget> = Widget Function();

/// De condição passada cria um widget forncedido ou um sizedbox para ocupar espaço na tela.
class IdeVisibilityBuilder extends StatelessWidget {
  final IdeVisibilityWidget child;
  final bool condition;
  final double? width;
  final double? height;

  const IdeVisibilityBuilder({super.key, required this.condition, required this.child, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    if (width != null || height != null) {
      var width = this.width ?? 0;
      var height = this.height ?? 0;
      return condition ? child() : SizedBox(height: width, width: height);
    } else {
      return condition ? child() : const SizedBox.shrink();
    }
  }
}
