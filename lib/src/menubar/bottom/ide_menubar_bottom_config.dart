import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeMenubarBottomConfig extends StatelessWidget {
  final List<IdeMenubarBottomButton>? endChildren;
  const IdeMenubarBottomConfig({
    super.key,
    this.endChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: Ide.menubarBottom!.build(endChildren),
    );
  }
}
