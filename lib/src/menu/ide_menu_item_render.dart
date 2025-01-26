import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';
import 'package:idea/src/menu/submenu/ide_submenu_box_render.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeMenuItemRender extends StatefulWidget {
  final int index;
  final dynamic menu;
  final double width;

  const IdeMenuItemRender({required this.index, this.menu, required this.width, super.key});

  @override
  _IdeMenuItemRenderState createState() => _IdeMenuItemRenderState();
}

class _IdeMenuItemRenderState extends State<IdeMenuItemRender> {
  ThemeData? theme;
  IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");

  String uid = '';

  /// Status indica se o componente está habilitado
  bool isEnabled = true;

  bool isChecked = true;

  /// Status indica se o componente está com evento de hover
  bool isHover = false;

  Color get color {
    if ((isEnabled && (isHover || IdeMenu.activeMenuItemUid == uid))) {
      return Colors.white;
    } else if (isEnabled) {
      return Colors.black;
    } else {
      return Colors.black12;
    }
  }

  Color get colorIcon {
    if ((isEnabled && (isHover || IdeMenu.activeMenuItemUid == uid))) {
      return Colors.white;
    } else if (isEnabled) {
      return Colors.transparent;
    } else {
      return Colors.black12;
    }
  }

  Color get colorIconCheckbox {
    if ((isEnabled && (isHover || IdeMenu.activeMenuItemUid == uid))) {
      return Colors.white;
    } else if (isEnabled && isChecked) {
      return Colors.green;
    } else {
      return Colors.transparent;
    }
  }

  Color get backgroundColor {
    return (isEnabled && (isHover || IdeMenu.activeMenuItemUid == uid)) ? theme!.primaryColor : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Remover theme
    theme = Theme.of(context);

    isEnabled = widget.menu.enabled;
    //uid = widget.menu.uid ?? ApiSecurity.uidSha1(widget.menu.title);
    uid = widget.menu.uid ?? widget.menu.title;

    if (widget.menu.isChecked != null) {
      isChecked = widget.menu.isChecked;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          color: backgroundColor,
          child: MouseRegion(
            onEnter: (PointerEvent e) {
              setState(
                () {
                  if (menuScreenOverlayState != null) {
                    menuScreenOverlayState!.resetSubmenu();
                    IdeMenu.isMenuItemSelected = false;
                    IdeMenu.activeMenuItemUid = '';
                    isHover = true;
                    if (isEnabled) {
                      IdeMenu.activeMenuItemUid = uid;
                      if (Ide.menuOverlay != null) {
                        menuScreenOverlayState!.resetSubmenu();
                        if (widget.menu.children != null) {
                          menuScreenOverlayState!.configRenderSubmenu(
                            child: IdeSubmenuBoxRender(
                              children: widget.menu.children,
                              width: widget.menu.width,
                            ),
                            rect: IdePosition.global(context, Offset.zero),
                            width: constraints.constrainWidth(),
                          );
                        }
                      }
                    }
                  }
                },
              );
            },
            onExit: (PointerEvent e) {
              setState(() {
                isHover = false;
                if (widget.menu.children == null && Ide.menuOverlay != null) {
                  if (menuScreenOverlayState != null) {
                    menuScreenOverlayState!.resetSubmenu();
                  }
                  IdeMenu.isMenuItemSelected = false;
                  IdeMenu.activeMenuItemUid = '';
                }
              });
            },
            child: GestureDetector(
              onTap: () {
                if (widget.menu.children == null) {
                  if (widget.menu.menuEvent != null) {
                    if (widget.menu.isChecked) {}
                    widget.menu.onEvent(widget.menu.menuEvent.response());
                  } else {
                    throw ("Nenhum evento registrado para o item de menubar B'${widget.menu.title}'");
                  }
                  if (menuScreenOverlayState != null) {
                    menuScreenOverlayState!.resetMenu();
                  }
                }
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(0),
                height: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IdeVisibilityToggle(
                      condition: isChecked,
                      firstChild: () => SizedBox(
                        width: 24,
                        height: 24,
                        child: Center(
                          child: Icon(
                            Icons.check_rounded,
                            size: 20.0,
                            color: colorIconCheckbox,
                          ),
                        ),
                      ),
                      secondChild: () => Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Center(
                          child: IdeVisibilityBuilder(
                            condition: !isChecked && widget.menu.icon != null,
                            child: () => Icon(
                              widget.menu.icon,
                              size: 18,
                              color: colorIcon,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 1),
                        child: Text(
                          widget.menu.title,
                          style: TextStyle(fontSize: 13, color: color),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IdeVisibilityBuilder(
                      condition: widget.width >= 150 && ((widget.menu.shortcut as String).isNotEmpty && widget.menu.children == null),
                      child: () => Container(
                        width: 70,
                        padding: const EdgeInsets.only(right: 9, top: 6, bottom: 1),
                        child: (widget.menu.shortcut as String).isNotEmpty
                            ? Text(
                                widget.menu.shortcut,
                                style: TextStyle(fontSize: 12, color: color),
                                textAlign: TextAlign.right,
                                maxLines: 1,
                              )
                            : const SizedBox(width: 0, height: 0),
                      ),
                    ),
                    IdeVisibilityBuilder(
                      condition: widget.width >= 50 && (widget.menu.children != null),
                      child: () => Container(
                        padding: const EdgeInsets.only(right: 3, top: 2),
                        child: Icon(
                          Icons.arrow_right,
                          size: 20.0,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
