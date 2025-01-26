import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';

typedef ValueChangedCallback<T> = void Function(T value, dynamic callback);

// ignore: must_be_immutable
class IdeSidenavItem extends StatefulWidget {
  final String label;
  final double? progress;
  final bool enabled;
  final VoidCallback? onPressed;
  final String value;
  final String menu;
  final List<IdeSidenavSubitem>? subitems;
  final IconData icon;
  final String? iconSvg;
  final double iconSize;
  final IdeSidenavObserverType observerType;
  ValueChangedCallback<bool>? onExpansionChanged;
  final String id;

  IdeSidenavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.id,
    this.iconSvg,
    this.enabled = true,
    this.progress,
    this.menu = '',
    this.subitems,
    this.value = '',
    this.onPressed,
    this.onExpansionChanged,
    this.iconSize = 20,
    this.observerType = IdeSidenavObserverType.content,
  }) : assert(!(progress != null && subitems != null),
            "IdeSidenavItem: Não é permitido configurar 'progress' e 'subitems' em um mesmo tempo.");

  @override
  IdeSidenavItemState createState() => IdeSidenavItemState();
}

class IdeSidenavItemState extends State<IdeSidenavItem> {
  ThemeData? theme;
  String uid = '';
  bool isHover = false;

  bool _allowMultipleOpen = false;

  void set allowMultipleOpen(bool value) {
    _allowMultipleOpen = value;
  }


  Color get color {
    Color result = isHover ? theme!.primaryColor.withValues(alpha: 0.2) : Colors.transparent;

    if (Ide.sidenavManager.isActiveSelected(uid)) {
      result = theme!.primaryColor.withValues(alpha: 0.5);
    }
    return result;
  }

  double get right {
    int length = 3;
    double size = 40;
    if (widget.value.isNotEmpty) {
      length = (widget.value.length);
    }
    if (length > 2) {
      size = 30;
    }
    if (length > 3) {
      size = 40;
    }

    return size;
  }

  // Função de expansão do menu
  void onExpansion() {
    if (widget.subitems != null) {
      Ide.sidenavManager.activeOpened = uid;
      Ide.sidenavManager.activeSelected = '';

      // Verifica se existe um callback de expansão e executa
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(Ide.sidenavManager.isActiveOpened(uid), () {
          setState(() {});
        });
      }
    } else {
      Ide.sidenavManager.activeSelected = uid;
    }

    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  void initState() {
    super.initState();
    //uid = ApiSecurity.uidSha1(widget.id);
    uid = widget.id;
    Ide.sidenavManager.addSidenavItemState(uid, this);
  }

  redraw() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    //uid = ApiSecurity.uidSha1(widget.id);
    uid = widget.id;

    const Color colorDefault = Colors.black87;

    if (widget.subitems != null) {
      for (var submenu in widget.subitems!) {
        submenu.uidParent = uid;
      }
    }

    if (Ide.sidenavManager.isActiveSelected(uid)) {
      Ide.sidenavManager.activeOpened = uid;
    }

    return Obx(()=>Column(
      children: [
        IgnorePointer(
          ignoring: (!(widget.onPressed != null || widget.subitems != null) && !widget.enabled),
          child: Opacity(
            opacity: ((widget.onPressed != null || widget.subitems != null) && widget.enabled) ? 1 : 0.3,
            child: InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onHover: (bool value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    isHover = value;
                  });
                });
              },
              onTap: ((widget.onPressed != null || widget.subitems != null) && widget.enabled) ? onExpansion : null,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: Opacity(
                        opacity: isHover ? 1 : 0,
                        child: Container(
                          width: 4,
                          height: 32,
                          decoration: BoxDecoration(
                            color: theme!.primaryColor,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 8,
                      child: widget.iconSvg != null
                          ? SvgPicture.string(
                        widget.iconSvg!,
                        width: widget.iconSize,
                        height: widget.iconSize,
                        colorFilter: isHover || Ide.sidenavManager.isActiveSelected(uid)
                            ? const ColorFilter.mode(colorDefault, BlendMode.srcIn)
                            : const ColorFilter.mode(Color(0xFF767676), BlendMode.srcIn),
                      )
                          : Icon(
                        widget.icon,
                        size: widget.iconSize,
                        color: isHover || Ide.sidenavManager.isActiveSelected(uid) ? colorDefault : const Color(0xFF767676),
                      ),
                    ),
                    Positioned(
                      top: 7,
                      left: 35,
                      right: right,
                      child: Container(
                        color: Colors.transparent,
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: isHover || Ide.sidenavManager.isActiveSelected(uid) ? colorDefault : const Color(0xFF767676),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          softWrap: false,
                        ),
                      ),
                    ),
                    menuOptions(context, onExpansion),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Build dos items de submenus
        IdeVisibilityBuilder(
          condition: widget.subitems != null && Ide.sidenavManager.isActiveOpened(uid),
          child: () => Column(
            children: widget.subitems!,
          ),
        ),
      ],
    ));
  }

  Widget menuOptions(BuildContext context, Function()? onExpansion) {
    if (widget.value.isNotEmpty) {
      return Positioned(
        right: 8,
        top: 6,
        child: IdeVisibilityBuilder(
          condition: widget.value.isNotEmpty,
          child: () => Text(
            widget.value,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      );
    } else if (widget.progress != null) {
      return Positioned(
        right: 8,
        top: 7,
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            value: widget.progress,
            strokeWidth: 3,
            backgroundColor: Colors.black12,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
      );
    } else if (widget.menu.isNotEmpty) {
      return Positioned(
        right: 4,
        top: 3,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Icon(
              Icons.more_vert,
              size: 24,
              //color: isHover || Ide.isHoverMenu(uid) ? theme!.primaryColor : const Color(0xFF767676),
              color: isHover ? theme!.primaryColor : const Color(0xFF767676),
            ),
          ),
        ),
      );
    } else if (widget.subitems != null) {
      return Positioned(
        right: 4,
        top: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: theme!.primaryColor.withValues(alpha: 0.1),
              onTap: onExpansion,
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Icon(
                  Ide.sidenavManager.isActiveOpened(uid) ? Icons.expand_less_outlined : Icons.expand_more_outlined,
                  size: 24,
                  color: isHover ? theme!.primaryColor : const Color(0xFF767676),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return const Positioned(
        right: 10,
        top: 7,
        child: SizedBox.shrink(),
      );
    }
  }
}
