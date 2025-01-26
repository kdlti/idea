// A library of Flutter widgets that allow creating ideExpandable panels
library ide_expandable;

import 'dart:math' as math;

import 'package:flutter/material.dart';

class IdeExpandableThemeData {
  static const IdeExpandableThemeData defaults = IdeExpandableThemeData(
    iconColor: Colors.black54,
    useInkWell: true,
    inkWellBorderRadius: BorderRadius.zero,
    animationDuration: Duration(milliseconds: 300),
    scrollAnimationDuration: Duration(milliseconds: 300),
    crossFadePoint: 0.5,
    fadeCurve: Curves.linear,
    sizeCurve: Curves.fastOutSlowIn,
    alignment: Alignment.topLeft,
    headerAlignment: IdeExpandablePanelHeaderAlignment.top,
    bodyAlignment: IdeExpandablePanelBodyAlignment.left,
    iconPlacement: IdeExpandablePanelIconPlacement.right,
    tapHeaderToExpand: true,
    tapBodyToExpand: false,
    tapBodyToCollapse: false,
    hasIcon: true,
    iconSize: 24.0,
    iconPadding: EdgeInsets.all(8.0),
    iconRotationAngle: -math.pi,
    expandIcon: Icons.expand_more,
    collapseIcon: Icons.expand_more,
  );

  static const IdeExpandableThemeData empty = IdeExpandableThemeData();

  // Expand icon color.
  final Color? iconColor;

  // If true then [InkWell] will be used in the header for a ripple effect.
  final bool? useInkWell;

  // The duration of the transition between collapsed and expanded states.
  final Duration? animationDuration;

  // The duration of the scroll animation to make the expanded widget visible.
  final Duration? scrollAnimationDuration;

  /// The point in the cross-fade animation timeline (from 0 to 1)
  /// where the [collapsed] and [expanded] widgets are half-visible.
  ///
  /// If set to 0, the [expanded] widget will be shown immediately in full opacity
  /// when the size transition starts. This is useful if the collapsed widget is
  /// empty or if dealing with text that is shown partially in the collapsed state.
  /// This is the default value.
  ///
  /// If set to 0.5, the [expanded] and the [collapsed] widget will be shown
  /// at half of their opacity in the middle of the size animation with a
  /// cross-fade effect throughout the entire size transition.
  ///
  /// If set to 1, the [expanded] widget will be shown at the very end of the size animation.
  ///
  /// When collapsing, the effect of this setting is reversed. For example, if the value is 0
  /// then the [expanded] widget will remain to be shown until the end of the size animation.
  final double? crossFadePoint;

  /// The alignment of widgets during animation between expanded and collapsed states.
  final AlignmentGeometry? alignment;

  // Fade animation curve between expanded and collapsed states.
  final Curve? fadeCurve;

  // Size animation curve between expanded and collapsed states.
  final Curve? sizeCurve;

  // The alignment of the header for `IdeExpandablePanel`.
  final IdeExpandablePanelHeaderAlignment? headerAlignment;

  // The alignment of the body for `IdeExpandablePanel`.
  final IdeExpandablePanelBodyAlignment? bodyAlignment;

  /// Expand icon placement.
  final IdeExpandablePanelIconPlacement? iconPlacement;

  /// If true, the header of [IdeExpandablePanel] can be clicked by the user to expand or collapse.
  final bool? tapHeaderToExpand;

  /// If true, the body of [IdeExpandablePanel] can be clicked by the user to expand.
  final bool? tapBodyToExpand;

  /// If true, the body of [IdeExpandablePanel] can be clicked by the user to collapse.
  final bool? tapBodyToCollapse;

  /// If true, an icon is shown in the header of [IdeExpandablePanel].
  final bool? hasIcon;

  /// Expand icon size.
  final double? iconSize;

  /// Expand icon padding.
  final EdgeInsets? iconPadding;

  /// Icon rotation angle in clockwise radians. For example, specify `math.pi` to rotate the icon by 180 degrees
  /// clockwise when clicking on the expand button.
  final double? iconRotationAngle;

  /// The icon in the collapsed state.
  final IconData? expandIcon;

  /// The icon in the expanded state. If you specify the same icon as `expandIcon`, the `expandIcon` icon will
  /// be shown upside-down in the expanded state.
  final IconData? collapseIcon;

  ///The [BorderRadius] for the [InkWell], if `inkWell` is set to true
  final BorderRadius? inkWellBorderRadius;

  const IdeExpandableThemeData({
    this.iconColor,
    this.useInkWell,
    this.animationDuration,
    this.scrollAnimationDuration,
    this.crossFadePoint,
    this.fadeCurve,
    this.sizeCurve,
    this.alignment,
    this.headerAlignment,
    this.bodyAlignment,
    this.iconPlacement,
    this.tapHeaderToExpand,
    this.tapBodyToExpand,
    this.tapBodyToCollapse,
    this.hasIcon,
    this.iconSize,
    this.iconPadding,
    this.iconRotationAngle,
    this.expandIcon,
    this.collapseIcon,
    this.inkWellBorderRadius,
  });

  static IdeExpandableThemeData combine(IdeExpandableThemeData? theme, IdeExpandableThemeData? defaults) {
    if (defaults == null || defaults.isEmpty()) {
      return theme ?? empty;
    } else if (theme == null || theme.isEmpty()) {
      return defaults;
    } else if (theme.isFull()) {
      return theme;
    } else {
      return IdeExpandableThemeData(
        iconColor: theme.iconColor ?? defaults.iconColor,
        useInkWell: theme.useInkWell ?? defaults.useInkWell,
        inkWellBorderRadius: theme.inkWellBorderRadius ?? defaults.inkWellBorderRadius,
        animationDuration: theme.animationDuration ?? defaults.animationDuration,
        scrollAnimationDuration: theme.scrollAnimationDuration ?? defaults.scrollAnimationDuration,
        crossFadePoint: theme.crossFadePoint ?? defaults.crossFadePoint,
        fadeCurve: theme.fadeCurve ?? defaults.fadeCurve,
        sizeCurve: theme.sizeCurve ?? defaults.sizeCurve,
        alignment: theme.alignment ?? defaults.alignment,
        headerAlignment: theme.headerAlignment ?? defaults.headerAlignment,
        bodyAlignment: theme.bodyAlignment ?? defaults.bodyAlignment,
        iconPlacement: theme.iconPlacement ?? defaults.iconPlacement,
        tapHeaderToExpand: theme.tapHeaderToExpand ?? defaults.tapHeaderToExpand,
        tapBodyToExpand: theme.tapBodyToExpand ?? defaults.tapBodyToExpand,
        tapBodyToCollapse: theme.tapBodyToCollapse ?? defaults.tapBodyToCollapse,
        hasIcon: theme.hasIcon ?? defaults.hasIcon,
        iconSize: theme.iconSize ?? defaults.iconSize,
        iconPadding: theme.iconPadding ?? defaults.iconPadding,
        iconRotationAngle: theme.iconRotationAngle ?? defaults.iconRotationAngle,
        expandIcon: theme.expandIcon ?? defaults.expandIcon,
        collapseIcon: theme.collapseIcon ?? defaults.collapseIcon,
      );
    }
  }

  double get collapsedFadeStart => crossFadePoint! < 0.5 ? 0 : (crossFadePoint! * 2 - 1);

  double get collapsedFadeEnd => crossFadePoint! < 0.5 ? 2 * crossFadePoint! : 1;

  double get expandedFadeStart => crossFadePoint! < 0.5 ? 0 : (crossFadePoint! * 2 - 1);

  double get expandedFadeEnd => crossFadePoint! < 0.5 ? 2 * crossFadePoint! : 1;

  IdeExpandableThemeData? nullIfEmpty() {
    return isEmpty() ? null : this;
  }

  bool isEmpty() {
    return this == empty;
  }

  bool isFull() {
    return iconColor != null &&
        useInkWell != null &&
        inkWellBorderRadius != null &&
        animationDuration != null &&
        scrollAnimationDuration != null &&
        crossFadePoint != null &&
        fadeCurve != null &&
        sizeCurve != null &&
        alignment != null &&
        headerAlignment != null &&
        bodyAlignment != null &&
        iconPlacement != null &&
        tapHeaderToExpand != null &&
        tapBodyToExpand != null &&
        tapBodyToCollapse != null &&
        hasIcon != null &&
        iconRotationAngle != null &&
        expandIcon != null &&
        collapseIcon != null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is IdeExpandableThemeData) {
      return iconColor == other.iconColor &&
          useInkWell == other.useInkWell &&
          inkWellBorderRadius == other.inkWellBorderRadius &&
          animationDuration == other.animationDuration &&
          scrollAnimationDuration == other.scrollAnimationDuration &&
          crossFadePoint == other.crossFadePoint &&
          fadeCurve == other.fadeCurve &&
          sizeCurve == other.sizeCurve &&
          alignment == other.alignment &&
          headerAlignment == other.headerAlignment &&
          bodyAlignment == other.bodyAlignment &&
          iconPlacement == other.iconPlacement &&
          tapHeaderToExpand == other.tapHeaderToExpand &&
          tapBodyToExpand == other.tapBodyToExpand &&
          tapBodyToCollapse == other.tapBodyToCollapse &&
          hasIcon == other.hasIcon &&
          iconRotationAngle == other.iconRotationAngle &&
          expandIcon == other.expandIcon &&
          collapseIcon == other.collapseIcon;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    return 0; // we don't care
  }

  static IdeExpandableThemeData of(BuildContext context, {bool rebuildOnChange = true}) {
    final notifier = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<_IdeExpandableThemeNotifier>()
        : context.findAncestorWidgetOfExactType<_IdeExpandableThemeNotifier>();
    return notifier?.themeData ?? defaults;
  }

  static IdeExpandableThemeData withDefaults(IdeExpandableThemeData? theme, BuildContext context, {bool rebuildOnChange = true}) {
    if (theme != null && theme.isFull()) {
      return theme;
    } else {
      return combine(combine(theme, of(context, rebuildOnChange: rebuildOnChange)), defaults);
    }
  }
}

class IdeExpandableTheme extends StatelessWidget {
  final IdeExpandableThemeData data;
  final Widget child;

  const IdeExpandableTheme({super.key, required this.data, required this.child});

  @override
  Widget build(BuildContext context) {
    _IdeExpandableThemeNotifier? n = context.dependOnInheritedWidgetOfExactType<_IdeExpandableThemeNotifier>();
    return _IdeExpandableThemeNotifier(
      themeData: IdeExpandableThemeData.combine(data, n?.themeData),
      child: child,
    );
  }
}

/// Makes an [IdeExpandableController] available to the widget subtree.
/// Useful for making multiple [IdeExpandable] widgets synchronized with a single controller.
class IdeExpandableNotifier extends StatefulWidget {
  final IdeExpandableController? controller;
  final bool? initialExpanded;
  final Widget child;

  const IdeExpandableNotifier(
      {
      // An optional key
      super.key,

      /// If the controller is not provided, it's created with the initial value of `initialExpanded`.
      this.controller,

      /// Initial expanded state. Must not be used together with [controller].
      this.initialExpanded,

      /// The child can be any widget which contains [IdeExpandable] widgets in its widget tree.
      required this.child})
      : assert(!(controller != null && initialExpanded != null));

  @override
  State<IdeExpandableNotifier> createState() => _IdeExpandableNotifierState();
}

class _IdeExpandableNotifierState extends State<IdeExpandableNotifier> {
  IdeExpandableController? controller;
  IdeExpandableThemeData? theme;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? IdeExpandableController(initialExpanded: widget.initialExpanded ?? false);
  }

  @override
  void didUpdateWidget(IdeExpandableNotifier oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller && widget.controller != null) {
      setState(() {
        controller = widget.controller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cn = _IdeExpandableControllerNotifier(controller: controller, child: widget.child);
    return theme != null ? _IdeExpandableThemeNotifier(themeData: theme, child: cn) : cn;
  }
}

/// Makes an [IdeExpandableController] available to the widget subtree.
/// Useful for making multiple [IdeExpandable] widgets synchronized with a single controller.
class _IdeExpandableControllerNotifier extends InheritedNotifier<IdeExpandableController> {
  const _IdeExpandableControllerNotifier({required IdeExpandableController? controller, required super.child})
      : super(notifier: controller);
}

/// Makes an [IdeExpandableController] available to the widget subtree.
/// Useful for making multiple [IdeExpandable] widgets synchronized with a single controller.
class _IdeExpandableThemeNotifier extends InheritedWidget {
  final IdeExpandableThemeData? themeData;

  const _IdeExpandableThemeNotifier({required this.themeData, required super.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return !(oldWidget is _IdeExpandableThemeNotifier && oldWidget.themeData == themeData);
  }
}

/// Controls the state (expanded or collapsed) of one or more [IdeExpandable].
/// The controller should be provided to [IdeExpandable] via [IdeExpandableNotifier].
class IdeExpandableController extends ValueNotifier<bool> {
  /// Returns [true] if the state is expanded, [false] if collapsed.
  bool get expanded => value;

  IdeExpandableController({
    bool? initialExpanded,
  }) : super(initialExpanded ?? false);

  /// Sets the expanded state.
  set expanded(bool exp) {
    value = exp;
  }

  /// Sets the expanded state to the opposite of the current state.
  void toggle() {
    expanded = !expanded;
  }

  void close() {
    expanded = false;
  }

  void open() {
    expanded = true;
  }

  static IdeExpandableController? of(BuildContext context, {bool rebuildOnChange = true, bool required = false}) {
    final notifier = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<_IdeExpandableControllerNotifier>()
        : context.findAncestorWidgetOfExactType<_IdeExpandableControllerNotifier>();
    assert(notifier != null || !required, "IdeExpandableNotifier is not found in widget tree");
    return notifier?.notifier;
  }
}

/// Shows either the expanded or the collapsed child depending on the state.
/// The state is determined by an instance of [IdeExpandableController] provided by [ScopedModel]
class IdeExpandable extends StatelessWidget {
  /// Whe widget to show when collapsed
  final Widget collapsed;

  /// The widget to show when expanded
  final Widget expanded;

  /// If true, the widget will be rebuilt when the controller notifies its listeners
  final bool rebuildOnChange;

  /// If the controller is not specified, it will be retrieved from the context
  final IdeExpandableController? controller;
  final IdeExpandableThemeData? theme;

  IdeExpandableController? localController;

  IdeExpandable({
    super.key,
    required this.collapsed,
    required this.expanded,
    this.controller,
    this.theme,
    this.rebuildOnChange = false,
  });

  void close() {
    localController?.close();
  }

  void open() {
    localController?.open();
  }

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? IdeExpandableController.of(context, required: true);
    localController = controller;
    final theme = IdeExpandableThemeData.withDefaults(this.theme, context);

    return AnimatedCrossFade(
      alignment: theme.alignment!,
      firstChild: collapsed,
      secondChild: rebuildOnChange ? _buildExpandedWithConditionalKey(controller!, expanded, rebuildOnChange) : expanded,
      firstCurve: Interval(theme.collapsedFadeStart, theme.collapsedFadeEnd, curve: theme.fadeCurve!),
      secondCurve: Interval(theme.expandedFadeStart, theme.expandedFadeEnd, curve: theme.fadeCurve!),
      sizeCurve: theme.sizeCurve!,
      crossFadeState: controller?.expanded ?? true ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: theme.animationDuration!,
    );
  }
}

// Função para criar o widget expanded com uma Key dinâmica somente quando expandido
Widget _buildExpandedWithConditionalKey(IdeExpandableController controller, Widget expanded, bool rebuildOnChange) {
  if (controller.expanded) {
    return expanded;
  } else {
    // Se estiver colapsado, não queremos forçar a recriação
    return const SizedBox.shrink();
  }
}

typedef IdeExpandableBuilder = Widget Function(BuildContext context, Widget collapsed, Widget expanded);

/// Determines the placement of the expand/collapse icon in [IdeExpandablePanel]
enum IdeExpandablePanelIconPlacement {
  /// The icon is on the left of the header
  left,

  /// The icon is on the right of the header
  right,
}

/// Determines the alignment of the header relative to the expand icon
enum IdeExpandablePanelHeaderAlignment {
  /// The header and the icon are aligned at their top positions
  top,

  /// The header and the icon are aligned at their center positions
  center,

  /// The header and the icon are aligned at their bottom positions
  bottom,
}

/// Determines vertical alignment of the body
enum IdeExpandablePanelBodyAlignment {
  /// The body is positioned at the left
  left,

  /// The body is positioned in the center
  center,

  /// The body is positioned at the right
  right,
}

/// A configurable widget for showing user-ideExpandable content with an optional expand button.
class IdeExpandablePanel extends StatelessWidget {
  /// If specified, the header is always shown, and the ideExpandable part is shown under the header
  final Widget? header;

  /// The widget shown in the collapsed state
  final Widget collapsed;

  /// The widget shown in the expanded state
  final Widget expanded;

  /// Builds an IdeExpandable object, optional
  final IdeExpandableBuilder? builder;

  /// An optional controller. If not specified, a default controller will be
  /// obtained from a surrounding [IdeExpandableNotifier]. If that does not exist,
  /// the controller will be created with the initial state of [initialExpanded].
  final IdeExpandableController? controller;

  final IdeExpandableThemeData? theme;

  const IdeExpandablePanel({
    super.key,
    this.header,
    required this.collapsed,
    required this.expanded,
    this.controller,
    this.builder,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = IdeExpandableThemeData.withDefaults(this.theme, context);

    Widget buildHeaderRow() {
      CrossAxisAlignment calculateHeaderCrossAxisAlignment() {
        switch (theme.headerAlignment!) {
          case IdeExpandablePanelHeaderAlignment.top:
            return CrossAxisAlignment.start;
          case IdeExpandablePanelHeaderAlignment.center:
            return CrossAxisAlignment.center;
          case IdeExpandablePanelHeaderAlignment.bottom:
            return CrossAxisAlignment.end;
        }
      }

      Widget wrapWithIdeExpandableButton({required Widget? widget, required bool wrap}) {
        return wrap ? IdeExpandableButton(theme: theme, child: widget) : widget ?? Container();
      }

      if (!theme.hasIcon!) {
        return wrapWithIdeExpandableButton(widget: header, wrap: theme.tapHeaderToExpand!);
      } else {
        final rowChildren = <Widget>[
          Expanded(
            child: header ?? Container(),
          ),
          // ignore: deprecated_member_use_from_same_package
          wrapWithIdeExpandableButton(widget: IdeExpandableIcon(theme: theme), wrap: !theme.tapHeaderToExpand!)
        ];
        return wrapWithIdeExpandableButton(
            widget: Row(
              crossAxisAlignment: calculateHeaderCrossAxisAlignment(),
              children: theme.iconPlacement! == IdeExpandablePanelIconPlacement.right ? rowChildren : rowChildren.reversed.toList(),
            ),
            wrap: theme.tapHeaderToExpand!);
      }
    }

    Widget buildBody() {
      Widget wrapBody(Widget child, bool tap) {
        Alignment calcAlignment() {
          switch (theme.bodyAlignment!) {
            case IdeExpandablePanelBodyAlignment.left:
              return Alignment.topLeft;
            case IdeExpandablePanelBodyAlignment.center:
              return Alignment.topCenter;
            case IdeExpandablePanelBodyAlignment.right:
              return Alignment.topRight;
          }
        }

        final widget = Align(
          alignment: calcAlignment(),
          child: child,
        );

        if (!tap) {
          return widget;
        }
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: widget,
          onTap: () {
            final controller = IdeExpandableController.of(context);
            controller?.toggle();
          },
        );
      }

      final builder = this.builder ??
          (context, collapsed, expanded) {
            return IdeExpandable(
              collapsed: collapsed,
              expanded: expanded,
              theme: theme,
            );
          };

      return builder(context, wrapBody(collapsed, theme.tapBodyToExpand!), wrapBody(expanded, theme.tapBodyToCollapse!));
    }

    Widget buildWithHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeaderRow(),
          buildBody(),
        ],
      );
    }

    final panel = header != null ? buildWithHeader() : buildBody();

    if (controller != null) {
      return IdeExpandableNotifier(
        controller: controller,
        child: panel,
      );
    } else {
      final controller = IdeExpandableController.of(context, rebuildOnChange: false);
      if (controller == null) {
        return IdeExpandableNotifier(
          child: panel,
        );
      } else {
        return panel;
      }
    }
  }
}

/// An down/up arrow icon that toggles the state of [IdeExpandableController] when the user clicks on it.
/// The model is accessed via [ScopedModelDescendant].
class IdeExpandableIcon extends StatefulWidget {
  final IdeExpandableThemeData? theme;

  const IdeExpandableIcon({
    super.key,
    this.theme,
  });

  @override
  State<IdeExpandableIcon> createState() => _IdeExpandableIconState();
}

class _IdeExpandableIconState extends State<IdeExpandableIcon> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  IdeExpandableThemeData? theme;
  IdeExpandableController? controller;

  @override
  void initState() {
    super.initState();
    final theme = IdeExpandableThemeData.withDefaults(widget.theme, context, rebuildOnChange: false);
    animationController = AnimationController(duration: theme.animationDuration, vsync: this);
    animation = animationController!.drive(Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: theme.sizeCurve!)));
    controller = IdeExpandableController.of(context, rebuildOnChange: false, required: true);
    controller?.addListener(_expandedStateChanged);
    if (controller?.expanded ?? true) {
      animationController!.value = 1.0;
    }
  }

  @override
  void dispose() {
    controller?.removeListener(_expandedStateChanged);
    animationController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(IdeExpandableIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      theme = null;
    }
  }

  _expandedStateChanged() {
    if (controller!.expanded && const [AnimationStatus.dismissed, AnimationStatus.reverse].contains(animationController!.status)) {
      animationController!.forward();
    } else if (!controller!.expanded && const [AnimationStatus.completed, AnimationStatus.forward].contains(animationController!.status)) {
      animationController!.reverse();
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final controller2 = IdeExpandableController.of(context, rebuildOnChange: false, required: true);
    if (controller2 != controller) {
      controller?.removeListener(_expandedStateChanged);
      controller = controller2;
      controller?.addListener(_expandedStateChanged);
      if (controller?.expanded ?? true) {
        animationController!.value = 1.0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = IdeExpandableThemeData.withDefaults(widget.theme, context);

    return Padding(
      padding: theme.iconPadding!,
      child: AnimatedBuilder(
        animation: animation!,
        builder: (context, child) {
          final showSecondIcon = theme.collapseIcon! != theme.expandIcon! && animationController!.value >= 0.5;
          return Transform.rotate(
            angle: theme.iconRotationAngle! * (showSecondIcon ? -(1.0 - animationController!.value) : animationController!.value),
            child: Icon(
              showSecondIcon ? theme.collapseIcon! : theme.expandIcon!,
              color: theme.iconColor!,
              size: theme.iconSize!,
            ),
          );
        },
      ),
    );
  }
}

/// Toggles the state of [IdeExpandableController] when the user clicks on it.
class IdeExpandableButton extends StatelessWidget {
  final Widget? child;
  final IdeExpandableThemeData? theme;

  const IdeExpandableButton({super.key, this.child, this.theme});

  @override
  Widget build(BuildContext context) {
    final controller = IdeExpandableController.of(context, required: true);
    final theme = IdeExpandableThemeData.withDefaults(this.theme, context);

    if (theme.useInkWell!) {
      return InkWell(
        onTap: controller?.toggle,
        borderRadius: theme.inkWellBorderRadius!,
        child: child,
      );
    } else {
      return GestureDetector(
        onTap: controller?.toggle,
        child: child,
      );
    }
  }
}

/// Ensures that the child is visible on the screen by scrolling the outer viewport
/// when the outer [IdeExpandableNotifier] delivers a change event.
///
/// See also:
///
/// * [RenderObject.showOnScreen]
class IdeScrollOnExpand extends StatefulWidget {
  final Widget child;

  /// If true then the widget will be scrolled to become visible when expanded
  final bool scrollOnExpand;

  /// If true then the widget will be scrolled to become visible when collapsed
  final bool scrollOnCollapse;

  final IdeExpandableThemeData? theme;

  const IdeScrollOnExpand({
    super.key,
    required this.child,
    this.scrollOnExpand = true,
    this.scrollOnCollapse = true,
    this.theme,
  });

  @override
  State<IdeScrollOnExpand> createState() => _IdeScrollOnExpandState();
}

class _IdeScrollOnExpandState extends State<IdeScrollOnExpand> {
  IdeExpandableController? _controller;
  int _isAnimating = 0;
  BuildContext? _lastContext;
  IdeExpandableThemeData? _theme;

  @override
  void initState() {
    super.initState();
    _controller = IdeExpandableController.of(context, rebuildOnChange: false, required: true);
    _controller?.addListener(_expandedStateChanged);
  }

  @override
  void didUpdateWidget(IdeScrollOnExpand oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newController = IdeExpandableController.of(context, rebuildOnChange: false, required: true);
    if (newController != _controller) {
      _controller?.removeListener(_expandedStateChanged);
      _controller = newController;
      _controller?.addListener(_expandedStateChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(_expandedStateChanged);
  }

  _animationComplete() {
    _isAnimating--;
    if (_isAnimating == 0 && _lastContext != null && mounted) {
      if ((_controller?.expanded ?? true && widget.scrollOnExpand) || (!(_controller?.expanded ?? true) && widget.scrollOnCollapse)) {
        _lastContext?.findRenderObject()?.showOnScreen(duration: _animationDuration);
      }
    }
  }

  Duration get _animationDuration {
    return _theme?.scrollAnimationDuration ?? IdeExpandableThemeData.defaults.animationDuration!;
  }

  _expandedStateChanged() {
    if (_theme != null) {
      _isAnimating++;
      Future.delayed(_animationDuration + const Duration(milliseconds: 10), _animationComplete);
    }
  }

  @override
  Widget build(BuildContext context) {
    _lastContext = context;
    _theme = IdeExpandableThemeData.withDefaults(widget.theme, context);
    return widget.child;
  }
}
