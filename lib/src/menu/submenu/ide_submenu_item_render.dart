import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';

class IdeSubmenuItemRender extends StatefulWidget {
  final int index;
  final dynamic submenuItem;
  final double width;

  const IdeSubmenuItemRender({
    required this.index,
    this.submenuItem,
    required this.width,
    super.key,
  });

  @override
  IdeSubmenuItemRenderState createState() => IdeSubmenuItemRenderState();
}

class IdeSubmenuItemRenderState extends State<IdeSubmenuItemRender> {
  IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
  ThemeData? theme;

  /// Status indica se o componente está habilitado
  bool isEnabled = true;

  /// Status indica se o componente está com evento de hover
  bool isHover = false;

  bool isChecked = false;
  String uid = '';

  Color get color {
    if ((isEnabled && (isHover || IdeMenu.activeSubmenuUid == uid))) {
      return Colors.white;
    } else if (isEnabled) {
      return Colors.black;
    } else {
      return Colors.black38;
    }
  }

  Color get colorIcon {
    if ((isEnabled && (isHover || IdeMenu.activeSubmenuUid == uid))) {
      return Colors.white;
    } else if (isEnabled) {
      return Colors.black.withValues(alpha: 0.7);
    } else {
      return Colors.black26;
    }
  }

  Color get colorIconCheckbox {
    if ((isEnabled && (isHover || IdeMenu.activeSubmenuUid == uid))) {
      return Colors.white;
    } else if (isEnabled && isChecked) {
      return Colors.green;
    } else {
      return Colors.transparent;
    }
  }

  Color get backgroundColor {
    return (isEnabled && (isHover || IdeMenu.activeSubmenuUid == uid)) ? theme!.primaryColor : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    isEnabled = widget.submenuItem.enabled;
    //uid = widget.submenuItem.uid ?? ApiSecurity.uidSha1(widget.submenuItem.title);
    uid = widget.submenuItem.uid ?? widget.submenuItem.title;

    if (widget.submenuItem.isChecked) {
      isChecked = widget.submenuItem.isChecked;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          color: backgroundColor,
          child: MouseRegion(
            onEnter: (PointerEvent e) {
              setState(() {
                isHover = true;
                if (isEnabled) {
                  IdeMenu.activeSubmenuUid = uid;
                }
              });
            },
            onExit: (PointerEvent e) {
              setState(() {
                isHover = false;
                IdeMenu.activeSubmenuUid = '';
              });
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.submenuItem.menuEvent != null) {
                    widget.submenuItem.onEvent(widget.submenuItem.menuEvent.response());
                  } else {
                    throw ("Nenhum evento registrado para o item de menubar A'${widget.submenuItem.title}'");
                  }
                  if (Ide.menuOverlay != null && menuScreenOverlayState != null) {
                    menuScreenOverlayState!.resetMenu();
                  }
                  IdeMenu.isMenuItemSelected = false;
                  IdeMenu.activeMenuItemUid = '';
                });
              },
              child: Container(
                padding: const EdgeInsets.all(0),
                height: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IdeVisibilityToggle(
                      condition: widget.submenuItem.isChecked && isChecked,
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
                            condition: !widget.submenuItem.isChecked && widget.submenuItem.icon != null,
                            child: () => Icon(
                              widget.submenuItem.icon,
                              size: 18,
                              color: colorIcon,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 1),
                        child: Text(
                          ' ${widget.submenuItem.title}',
                          style: TextStyle(fontSize: 13, color: color),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IdeVisibilityBuilder(
                      condition: widget.width >= 150 && (widget.submenuItem.shortcut as String).isNotEmpty,
                      child: () => Container(
                        width: 70,
                        padding: const EdgeInsets.only(right: 9, top: 6, bottom: 1),
                        child: (widget.submenuItem.shortcut as String).isNotEmpty
                            ? Text(
                                widget.submenuItem.shortcut,
                                style: TextStyle(fontSize: 12, color: color),
                                textAlign: TextAlign.right,
                                maxLines: 1,
                              )
                            : const SizedBox(width: 0, height: 0),
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
