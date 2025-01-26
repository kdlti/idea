import 'package:flutter/material.dart';

class IdePanelLeftFooter extends StatelessWidget {
  final double height;
  final Widget? child;
  final bool visible;

  const IdePanelLeftFooter({
    this.child,
    this.height = 30,
    this.visible = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return () {
      if (visible) {
        return SizedBox(
          height: height,
          child: Center(
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                child ?? const SizedBox.shrink(),
              ],
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }();
  }
}
