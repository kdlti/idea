import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeMenubarRightLayout extends StatelessWidget {
  final List<IdeMenubarRightButton>? startChildren;
  final List<IdeMenubarRightButton>? endChildren;

  const IdeMenubarRightLayout({
    super.key,
    this.startChildren,
    this.endChildren,
  });

  @override
  Widget build(BuildContext context) {
    return IdeVisibilityBuilder(
      condition: Ide.hasMenubarRight,
      child: () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: Ide.menubarRight!.build(startChildren, endChildren),
      ),
    );
  }
}
