import 'package:flutter/material.dart';
import 'package:idea/package.dart';

// ignore: must_be_immutable
class IdeMenubarLeftConfig extends StatelessWidget {
  final List<IdeMenubarLeftButton>? startChildren;
  final List<IdeMenubarLeftButton>? endChildren;

  IdeMenubarLeftConfig({
    super.key,
    this.startChildren,
    this.endChildren,
  }) {
    _addStartButtons();
    _addEndButtons();
  }

  List<Widget> listMenu = [];

  void _addStartButtons() {
    if (startChildren != null && startChildren!.isNotEmpty) {
      for (var button in startChildren!) {
        listMenu.add(button);
      }
    }
  }

  void _addEndButtons() {
    if (endChildren != null && endChildren!.isNotEmpty) {
      listMenu.add(const Spacer());
      for (var button in endChildren!) {
        listMenu.add(button);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: listMenu,
    );
  }
}
