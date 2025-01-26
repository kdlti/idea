import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idea/package.dart';


/// Pass a list of children, and this will create a basic context menubar dynamically.
class IdeContextMenu extends StatefulWidget {
  final bool injectDividers;
  final bool autoClose;
  final IdeContextMenuButtonRenderStyle? buttonStyle;
  final List<IdeContextMenuButton?> children;

  const IdeContextMenu({
    super.key,
    required this.children,
    this.injectDividers = false,
    this.autoClose = true,
    this.buttonStyle,
  });

  @override
  _IdeGenericContextMenuState createState() => _IdeGenericContextMenuState();
}

class _IdeGenericContextMenuState extends State<IdeContextMenu> with IdeContextMenuStateMixin {
  @override
  Widget build(BuildContext context) {
    // Guard against an empty list
    if ((widget.children.isEmpty)) {
      // auto-close the menubar since it's empty
      scheduleMicrotask(() => context.contextMenuOverlay.hide());
      return Container(); // Need to return something, but it will be thrown away next frame.
    }
    // Interleave dividers into the menubar, use null as a marker to indicate a divider at some position.
    if (widget.injectDividers) {
      for (var i = widget.children.length - 2; i-- > 1; i++) {
        widget.children.add(null);
      }
    }
    return cardBuilder.call(
      context,
      // Create a list of Buttons / Dividers
      widget.children.map(
        (config) {
          // build a divider on null
          if (config == null) return buildDivider();
          // If not null, build a btn
          VoidCallback? action = config.onPressed;
          // Wrap external action in handlePressed so menubar will auto-close
          if (widget.autoClose && action != null) {
            action = () => handlePressed(context, config.onPressed!);
          }
          // Build btn
          return buttonBuilder.call(
              context,
              IdeContextMenuButton(
                config.label,
                icon: config.icon,
                iconHover: config.iconHover,
                shortcutLabel: config.shortcutLabel,
                onPressed: action,
              ),
              widget.buttonStyle);
        },
      ).toList(),
    );
  }
}
