import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdePanel extends StatelessWidget {
  final bool allowScroll;
  final IdePanelHeader? header;
  final IdePanelFooter? footer;
  final IdePanelStyle? style;
  final List<Widget> children;
  final double? height;

  /// How the children should be placed along the main axis.
  ///
  /// For example, [MainAxisAlignment.start], the default, places the children
  /// at the start (i.e., the left for a [Row] or the top for a [Column]) of the
  /// main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  ///
  /// For example, [CrossAxisAlignment.center], the default, centers the
  /// children in the cross axis (e.g., horizontally for a [Column]).
  ///
  /// When the cross axis is vertical (as for a [Row]) and the children
  /// contain text, consider using [CrossAxisAlignment.baseline] instead.
  /// This typically produces better visual results if the different children
  /// have text with different font metrics, for example because they differ in
  /// [TextStyle.fontSize] or other [TextStyle] properties, or because
  /// they use different fonts due to being written in different scripts.
  final CrossAxisAlignment crossAxisAlignment;

  const IdePanel({
    super.key,
    this.allowScroll = true,
    this.header,
    this.footer,
    this.style,
    this.height,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final IdePanelStyle defaultStyle = Theme.of(context).extension<IdePanelStyle>() ?? const IdePanelStyle();
    final EdgeInsetsGeometry? margin = style?.margin ?? defaultStyle.margin;
    final EdgeInsetsGeometry? padding = style?.padding ?? defaultStyle.padding;
    final BoxDecoration? decoration = style?.decoration ?? defaultStyle.decoration;

    // Define o widget de conteúdo (com ou sem scroll)
    final Widget content = allowScroll
        ? SingleChildScrollView(
            child: Container(
              margin: margin,
              padding: padding,
              decoration: decoration,
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment,
                children: children,
              ),
            ),
          )
        : Container(
            margin: margin,
            padding: padding,
            decoration: decoration,
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            ),
          );

    // Mantendo o Stack para garantir que header e footer fiquem fixos
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: decoration?.borderRadius ?? BorderRadius.zero,
        child: Stack(
          children: [
            if (header != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: header!.height,
                child: header!,
              ),
            Positioned(
              top: header?.height ?? 0,
              bottom: footer?.height ?? 0,
              left: 0,
              right: 0,
              child: content,
            ),
            if (footer != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: footer!.height,
                child: footer!,
              ),
          ],
        ),
      ),
    );
  }
}
