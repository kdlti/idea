import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeWorkspaceRender extends StatefulWidget {
  const IdeWorkspaceRender({super.key});

  @override
  State<IdeWorkspaceRender> createState() => _IdeWorkspaceRenderState();
}

class _IdeWorkspaceRenderState extends State<IdeWorkspaceRender> {
  void redraw() => setState(() {});

  @override
  void initState() {
    Ide.initState("IdeWorkspaceRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IdePosition position = IdePosition();

    if (Ide.hasAppbar && Ide.appbarVisible) {
      position.top = Ide.appbar!.position.top + Ide.appbar!.size.height;
    }
    if (Ide.hasToolbar && Ide.toolbarVisible) {
      position.top = Ide.toolbar!.position.top + Ide.toolbar!.size.height;
    }
    if (Ide.hasMenubarTop && Ide.menubarTopVisible) {
      position.top = Ide.menubarTop!.position.top + Ide.menubarTop!.size.height;
    }
    if (Ide.hasMenubarLeft && Ide.menubarLeftVisible) {
      position.left = Ide.menubarLeft!.position.left + Ide.menubarLeft!.size.width;
    }
    if (Ide.hasPanelLeft && Ide.panelLeftVisible && !Ide.panelLeft!.over) {
      position.left = Ide.panelLeft!.position.left + Ide.panelLeft!.size.width;
    }
    if (Ide.hasMenubarRight && Ide.menubarRightVisible) {
      position.right = Ide.menubarRight!.position.right + Ide.menubarRight!.size.width;
    }
    if (Ide.hasPanelRight && Ide.panelRightVisible && !Ide.panelRight!.overlay!) {
      position.right = Ide.panelRight!.position.right + Ide.panelRight!.size.width;
    }
    if (Ide.hasStatusbar && Ide.statusbarVisible) {
      position.bottom = Ide.statusbar!.position.bottom + Ide.statusbar!.size.height;
    }
    if (Ide.hasMenubarBottom && Ide.menubarBottomVisible) {
      position.bottom = Ide.menubarBottom!.position.bottom + Ide.menubarBottom!.size.height;
    }
    if (Ide.hasPanelBottom && Ide.panelBottomVisible) {
      position.bottom = Ide.panelBottom!.position.bottom + Ide.panelBottom!.size.height;
    }

    return Positioned(
      top: position.top,
      left: position.left,
      right: position.right,
      bottom: position.bottom,
      child: IndexedStack(
        index: Ide.workspaceManager!.activeIndex,
        children: Ide.workspaceManager!.contents,
      ),
    );
  }
}
