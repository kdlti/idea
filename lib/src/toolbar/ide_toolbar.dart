import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeToolbar {
  final IdeFunction<Widget> child;
  final double? height;
  final IdePosition position = IdePosition();
  final IdeSize size = IdeSize();
  final IdePushedByHorizontal pushedByHorizontal;
  //final String uid = ApiSecurity.uidSha1("toolbar");
  final String uid = "toolbar";
  final String id = "toolbar";
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Clip clipBehavior;
  bool visible;

  IdeToolbar({
    required this.child,
    this.visible = true,
    this.height = 40,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior = Clip.antiAlias,
    this.pushedByHorizontal = const IdePushedByHorizontal(),
  }) {
    resize();
  }

  void resize() {
    size.height = height!;
    position.reset();

    if (Ide.hasAppbar && Ide.appbarVisible) {
      position.top = Ide.appbar!.position.top + Ide.appbar!.size.height;
    }
    if (Ide.hasMenubarLeft && Ide.menubarLeftVisible && pushedByHorizontal.menubarLeft) {
      position.left = Ide.menubarLeft!.position.left + Ide.menubarLeft!.size.width;
    }

    if (Ide.hasPanelLeft && Ide.panelLeftVisible && pushedByHorizontal.panelLeft) {
      position.left = Ide.panelLeft!.position.left + Ide.panelLeft!.size.width;
    }

    if (Ide.hasMenubarRight && Ide.menubarRightVisible && pushedByHorizontal.menubarRight) {
      position.right = Ide.menubarRight!.position.left + Ide.menubarRight!.size.width;
    }

    if (Ide.hasPanelRight && Ide.panelRightVisible && pushedByHorizontal.panelRight) {
      position.right = position.right + Ide.panelRight!.position.left + Ide.panelRight!.size.width;
    }
  }

  Widget render() {
    return child();
  }
}
