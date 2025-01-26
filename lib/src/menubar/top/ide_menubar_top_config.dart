import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menubar/top/ide_menubar_top_menu_button.dart';

class IdeMenubarTopConfig extends StatelessWidget {
  final List<Widget> actions;
  final Key rowKey = GlobalKey();

  IdeMenubarTopConfig({
    super.key,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = Ide.workspaceManager!.tabs.length * 180;

        if (maxWidth > constraints.maxWidth) {
          List<IdeMenuItem> lisMenu = [];

          for (var ideContent in Ide.workspaceManager!.listContent) {
            lisMenu.add(
              IdeMenuItem(
                icon: ideContent.menubarTop!.tabbar!.icon,
                title: ideContent.menubarTop!.tabbar!.label,
                onEvent: (IdeMenuResponse menuResponse) {
                  print(ideContent.menubarTop!.tabbar!.label);
                },
              ),
            );
          }

          actions.insert(
            0,
            IdeMenubarTopMenuButton(
              icon: Icons.more_horiz_outlined,
              width: 25,
              height: 25,
              enabled: true,
              menu: lisMenu,
            ),
          );
        }

        return Row(
          key: rowKey,
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: Ide.workspaceManager!.tabs,
              ),
            ),
            actions.isNotEmpty ? Row(children: actions) : const SizedBox(),
          ],
        );
      },
    );
  }
}
