library context_menus;

import 'package:flutter/material.dart';

import 'widgets/ide_context_menu_button.dart';
import 'widgets/ide_context_menu_card.dart';
import 'widgets/ide_context_menu_divider.dart';
import 'widgets/ide_measure_size_widget.dart';

// The main overlay class, which should be nested between your top-most view and the MaterialApp.
// Wraps the main app view and shows a contextMenu and contextModal on top.
// This does not rely on Navigator.overlay, so you can place it around your Navigator,
// supporting context menus within persistent portions of your scaffold.
class IdeContextMenuOverlay extends StatefulWidget {
  const IdeContextMenuOverlay({
    super.key,
    required this.child,
    this.cardBuilder,
    this.buttonBuilder,
    this.dividerBuilder,
    this.buttonStyle = const IdeContextMenuButtonRenderStyle(),
  });
  final Widget child;

  /// Builds a card that wraps all the buttons in the menubar.
  final IdeContextMenuCardBuilder? cardBuilder;

  /// Builds a button for the menubar. It will be provided a [IdeContextMenuButton] and should return a button
  final IdeContextMenuButtonRenderBuilder? buttonBuilder;

  /// Builds a vertical or horizontal divider
  final IdeContextMenuDividerBuilder? dividerBuilder;

  /// Provide styles for the default context menubar buttons.
  /// You can ignore this if you're using a custom button builder, or use it if it works for your styling system.
  final IdeContextMenuButtonRenderStyle? buttonStyle;

  @override
  IdeContextMenuOverlayState createState() => IdeContextMenuOverlayState();

  static IdeContextMenuOverlayState of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<_InheritedContextMenuOverlay>() as _InheritedContextMenuOverlay).state;
}

class IdeContextMenuOverlayState extends State<IdeContextMenuOverlay> {
  static IdeContextMenuButtonRenderStyle defaultButtonStyle = const IdeContextMenuButtonRenderStyle();

  Widget? _currentMenu;
  Size? _prevSize;
  Size _menuSize = Size.zero;
  Offset _mousePos = Offset.zero;

  IdeContextMenuButtonRenderBuilder? get buttonBuilder => widget.buttonBuilder;

  IdeContextMenuDividerBuilder? get dividerBuilder => widget.dividerBuilder;

  IdeContextMenuCardBuilder? get cardBuilder => widget.cardBuilder;

  IdeContextMenuButtonRenderStyle get buttonStyle => widget.buttonStyle ?? defaultButtonStyle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        // Remove any open menus when we resize (common behavior, and avoids edge cases / complexity)
        _nullMenuIfOverlayWasResized(constraints);
        // Offset the menubar depending on which quadrant of the app we're in, this will make sure it always stays in bounds.
        double dx = 0, dy = 0;
        if (_mousePos.dx > (_prevSize?.width ?? 0) / 2) dx = -_menuSize.width;
        if (_mousePos.dy > (_prevSize?.height ?? 0) / 2) dy = -_menuSize.height;
        // The final menuPos, is mousePos + quadrant offset
        Offset menuPos = _mousePos + Offset(dx, dy);
        Widget? menuToShow = _currentMenu;

        return _InheritedContextMenuOverlay(
            state: this,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF2F3F7),
                      Color(0xFFF0EFED),
                    ],
                  ),
                ),
                child: Listener(
                  onPointerDown: (e) => _mousePos = e.localPosition,
                  // Listen for Notifications coming up from the app
                  child: Stack(
                    children: [
                      // Child is the contents of the overlay, usually the entire app.
                      widget.child,
                      // Show the menu?
                      if (menuToShow != null) ...[
                        Positioned.fill(child: Container(color: Colors.transparent)),

                        /// Underlay, blocks all taps to the main content.
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanStart: (_) => hide(),
                          onTap: () => hide(),
                          onSecondaryTapDown: (_) => hide(),
                          child: Container(),
                        ),

                        /// Position the menu contents
                        Transform.translate(
                          offset: menuPos,
                          child: Opacity(
                            opacity: _menuSize != Size.zero ? 1 : 0,
                            // Use a measure size widget so we can offset the child properly
                            child: IdeMeasuredSizeWidget(
                              key: ObjectKey(menuToShow),
                              onChange: _handleMenuSizeChanged,
                              child: IntrinsicWidth(child: IntrinsicHeight(child: menuToShow)),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  /// Sets the current menubar to be displayed.
  /// It will not be displayed until next frame, as the child needs to be measured first.
  void show(Widget child) {
    setState(() {
      //This will hide the widget until we can calculate it's size which should take 1 frame
      _menuSize = Size.zero;
      _currentMenu = child;
    });
  }

  /// Hides the current popup if there is one. Fails silently if not.
  void hide() {
    setState(() => _currentMenu = null);
  }

  /// re-position and rebuild whenever menubar size changes
  void _handleMenuSizeChanged(Size value) => setState(() => _menuSize = value);

  /// Auto-close the menubar when app size changes.
  /// This is classic context menubar behavior at the OS level and we'll follow it because it makes life much easier :D
  void _nullMenuIfOverlayWasResized(BoxConstraints constraints) {
    final size = constraints.biggest;
    bool appWasResized = size != _prevSize;
    if (appWasResized) _currentMenu = null;
    _prevSize = size;
  }
}

/// InheritedWidget boilerplate
class _InheritedContextMenuOverlay extends InheritedWidget {
  const _InheritedContextMenuOverlay({required super.child, required this.state});

  final IdeContextMenuOverlayState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
