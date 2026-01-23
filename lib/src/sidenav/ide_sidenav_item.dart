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
  }) : assert(!(progress != null && subitems != null), "IdeSidenavItem: Não é permitido configurar 'progress' e 'subitems' ao mesmo tempo.");

  @override
  State<IdeSidenavItem> createState() => IdeSidenavItemState();
}

class IdeSidenavItemState extends State<IdeSidenavItem> {
  late final String uid = widget.id;
  bool isHover = false;

  double get right {
    int length = widget.value.isNotEmpty ? widget.value.length : 3;
    double size = 40;
    if (length > 2) size = 30;
    if (length > 3) size = 40;
    return size;
  }

  void _handleTap() {
    final hasSubitems = widget.subitems != null;
    if (hasSubitems) {
      Ide.sidenavManager.toggleOpen(uid);
      Ide.sidenavManager.activeSelected = "";

      final isOpen = Ide.sidenavManager.isOpen(uid);
      widget.onExpansionChanged?.call(isOpen, () {});
    } else {
      Ide.sidenavManager.activeSelected = uid;
    }

    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const Color colorDefault = Colors.black87;

    // Mantendo sua lógica atual de setar uidParent nos subitems
    if (widget.subitems != null) {
      for (final submenu in widget.subitems!) {
        submenu.uidParent = uid;
      }
    }

    final bool isClickable = widget.enabled && (widget.onPressed != null || widget.subitems != null);

    return Obx(() {
      final bool isOpen = Ide.sidenavManager.isOpen(uid);
      final bool isSelected = Ide.sidenavManager.isActiveSelected(uid);

      final Color bgColor = isSelected ? theme.primaryColor.withValues(alpha: 0.5) : (isHover ? theme.primaryColor.withValues(alpha: 0.2) : Colors.transparent);

      final Color fgColor = (isHover || isSelected) ? colorDefault : const Color(0xFF767676);

      return Column(
        children: [
          IgnorePointer(
            ignoring: !isClickable,
            child: Opacity(
              opacity: isClickable ? 1 : 0.3,
              child: InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onHover: (value) => setState(() => isHover = value),
                onTap: isClickable ? _handleTap : null,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 32,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
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
                              color: theme.primaryColor,
                              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 8,
                        child: widget.iconSvg != null
                            ? SvgPicture.string(widget.iconSvg!, width: widget.iconSize, height: widget.iconSize, colorFilter: ColorFilter.mode(fgColor, BlendMode.srcIn))
                            : Icon(widget.icon, size: widget.iconSize, color: fgColor),
                      ),
                      Positioned(
                        top: 7,
                        left: 35,
                        right: right,
                        child: Text(
                          widget.label,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: fgColor),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          softWrap: false,
                        ),
                      ),
                      menuOptions(context, isOpen: isOpen, onToggle: widget.subitems != null ? () => Ide.sidenavManager.toggleOpen(uid) : null),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Subitens (apenas UM lugar, sem duplicar lógica antiga)
          if (widget.subitems != null && isOpen) Column(children: widget.subitems!),
        ],
      );
    });
  }

  Widget menuOptions(BuildContext context, {required bool isOpen, VoidCallback? onToggle}) {
    final theme = Theme.of(context);

    if (widget.value.isNotEmpty) {
      return Positioned(right: 8, top: 6, child: Text(widget.value, style: const TextStyle(fontSize: 14)));
    }

    if (widget.progress != null) {
      return Positioned(
        right: 8,
        top: 7,
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(value: widget.progress, strokeWidth: 3, backgroundColor: Colors.black12, valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor)),
        ),
      );
    }

    if (widget.menu.isNotEmpty) {
      return Positioned(
        right: 4,
        top: 3,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Icon(Icons.more_vert, size: 24, color: isHover ? theme.primaryColor : const Color(0xFF767676)),
          ),
        ),
      );
    }

    if (widget.subitems != null) {
      return Positioned(
        right: 4,
        top: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: theme.primaryColor.withValues(alpha: 0.1),
              onTap: onToggle,
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Icon(isOpen ? Icons.expand_less_outlined : Icons.expand_more_outlined, size: 24, color: isHover ? theme.primaryColor : const Color(0xFF767676)),
              ),
            ),
          ),
        ),
      );
    }

    return const Positioned(right: 10, top: 7, child: SizedBox.shrink());
  }
}
