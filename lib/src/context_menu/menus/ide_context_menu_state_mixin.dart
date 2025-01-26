import 'package:flutter/widgets.dart';
import 'package:idea/package.dart';

/// Optional mixin for ContextMenu's. Provides:
/// handlePressed method that takes care of closing the menubar after some action has been run.
/// card, button and divider builders, that check the for a  parent [IdeContextMenuOverlay]
mixin IdeContextMenuStateMixin<T extends StatefulWidget> on State<T> {
  /// Convenience method to auto-close the context menubar when an action is triggered
  /// which you almost always want to do in a context menubar.
  void handlePressed(BuildContext context, VoidCallback action) {
    action.call();
    overlay.hide();
  }

  /// Shortcut call to [IdeContextMenuOverlay].of(context)
  IdeContextMenuOverlayState get overlay => IdeContextMenuOverlay.of(context);

  /// Receives a list of buttons, and should wrap them with some container and layout widget (col/row).
  /// Defaults to a [IdeContextMenuCard] which is just a column with a background.
  IdeContextMenuCardBuilder get cardBuilder => overlay.cardBuilder ?? (_, children) => IdeContextMenuCard(children: children);

  /// Passed a config and (optional) style, should return a single button.
  /// Defaults to [IdeContextMenuButtonRender]
  IdeContextMenuButtonRenderBuilder get buttonBuilder {
    return overlay.buttonBuilder ??
        (_, config, [style]) {
          return IdeContextMenuButtonRender(config, style: style ?? overlay.buttonStyle);
        };
  }

  /// Builds divider to separate sections in the menubar
  Widget buildDivider() => overlay.dividerBuilder?.call(context) ?? const IdeContextMenuDivider();
}
