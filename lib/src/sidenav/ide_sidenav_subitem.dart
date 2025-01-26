import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';

// ignore: must_be_immutable
class IdeSidenavSubitem extends StatefulWidget {
  final String label;
  final String id;
  final bool selected;
  final double? progress;
  final bool enabled;
  final VoidCallback? onPressed;
  final String value;
  final String menu;
  final IconData icon;
  final double iconSize;

  String? uidParent;

  IdeSidenavSubitem({
    super.key,
    required this.icon,
    required this.label,
    required this.id,
    this.enabled = true,
    this.selected = false,
    this.progress,
    this.menu = '',
    this.value = '',
    this.onPressed,
    this.iconSize = 18,
  });

  @override
  State<IdeSidenavSubitem> createState() => IdeSidenavSubitemState();
}

class IdeSidenavSubitemState extends State<IdeSidenavSubitem> {
  bool isHover = false;
  ThemeData? theme;
  String uid = '';

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
      size = 50;
    }
    if (length > 3) {
      size = 60;
    }
    return size;
  }

  @override
  void initState() {
    super.initState();
    //uid = ApiSecurity.uidSha1(widget.id);
    uid = widget.id;
    Ide.sidenavManager.addSidenavSubitemState(uid, this);
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

    bool isEnable = widget.enabled && widget.onPressed != null;

    return Obx(() => IgnorePointer(
          ignoring: !isEnable,
          child: Opacity(
            opacity: isEnable ? 1 : 0.3,
            child: InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onHover: (bool value) {
                setState(() {
                  isHover = value;
                });
              },
              onTap: widget.onPressed != null && isEnable
                  ? () {
                      Ide.sidenavManager.activeOpened = widget.uidParent!;
                      Ide.sidenavManager.activeSelected = uid;
                      widget.onPressed!();
                    }
                  : null,
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
                        opacity: isHover || Ide.sidenavManager.isActiveSelected(uid) ? 1 : 0,
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
                      left: 30,
                      top: 6,
                      child: Icon(
                        widget.icon,
                        size: widget.iconSize,
                        color: isHover || Ide.sidenavManager.isActiveSelected(uid) ? Colors.black87 : const Color(0xFF767676),
                      ),
                    ),
                    Positioned(
                      top: 7,
                      left: 60,
                      right: right,
                      child: Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: isHover || Ide.sidenavManager.isActiveSelected(uid) ? Colors.black87 : const Color(0xFF767676),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                      ),
                    ),
                    menuOptions(context),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget menuOptions(BuildContext context) {
    theme = Theme.of(context);

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
              color: isHover || Ide.sidenavManager.isActiveSelected(uid) ? theme!.primaryColor : const Color(0xFF767676),
            ),
          ),
        ),
      );
    } else {
      return const Positioned(
        right: 10,
        top: 7,
        child: SizedBox(width: 0, height: 0),
      );
    }
  }
}
