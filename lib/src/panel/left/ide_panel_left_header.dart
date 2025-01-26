import 'package:flutter/material.dart';
import 'package:idea/src/visibility/ide_visibility_builder.dart';

class IdePanelLeftHeader extends StatelessWidget {
  final double height;
  final Widget? child;
  final bool visible;

  const IdePanelLeftHeader({
    this.child,
    this.height = 0,
    this.visible = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return () {
      if (visible) {
        return SizedBox(
          height: height,
          child: IdeVisibilityBuilder(
            condition: child != null,
            child: () => child,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }();
  }
}
