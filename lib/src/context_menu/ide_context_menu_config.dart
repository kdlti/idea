// Helper widget, to dispatch Notifications when a panel-click is detected on some child
import 'package:flutter/widgets.dart';
import 'package:idea/package.dart';


/// Wraps any widget in a GestureDetector and calls [IdeContextMenuOverlay].show
class IdeContextMenuConfig extends StatelessWidget {
  final Widget child;
  final IdeContextMenu contextMenu;
  final bool isEnabled;
  final bool enableLongPress;

  const IdeContextMenuConfig({super.key, required this.child, required this.contextMenu, this.isEnabled = true, this.enableLongPress = true});

  @override
  Widget build(BuildContext context) {
    void showMenu() {
      // calculate widget position on screen
      context.contextMenuOverlay.show(contextMenu);
    }

    if (isEnabled == false) return child;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onSecondaryTap: showMenu,
      onLongPress: enableLongPress ? showMenu : null,
      child: child,
    );
  }
}
