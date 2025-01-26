import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KukaflixIconButton extends StatefulWidget {
  final String svgIcon;
  final String svgIconHover;
  final String svgIconPressed;
  final Color background;
  final Color backgroundHover;
  final Color backgroundPressed;

  final Color borderColor;
  final Color borderColorHover;
  final Color borderColorPressed;

  final Color iconColor;
  final Color iconColorHover;
  final Color iconColorPressed;

  final Color splashColor;
  final Color splashColorHover;
  final Color splashColorPressed;

  final EdgeInsetsGeometry? margin;
  final double width;
  final double height;
  final double borderWidth;
  final BorderRadiusGeometry? borderRadius;

  final VoidCallback onPressed;

  const KukaflixIconButton({
    super.key,
    required this.svgIcon,
    required this.svgIconHover,
    required this.svgIconPressed,
    required this.onPressed,
    required this.background,
    required this.backgroundHover,
    required this.backgroundPressed,
    required this.borderColor,
    required this.borderColorHover,
    required this.borderColorPressed,
    required this.iconColor,
    required this.iconColorHover,
    required this.iconColorPressed,
    required this.splashColor,
    required this.splashColorHover,
    required this.splashColorPressed,
    required this.margin,
    required this.width,
    required this.height,
    required this.borderWidth,
    required this.borderRadius,
  });

  @override
  State<KukaflixIconButton> createState() => _KukaflixIconButtonState();
}

class _KukaflixIconButtonState extends State<KukaflixIconButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: _isPressed
                ? widget.backgroundPressed
                : _isHovering
                    ? widget.backgroundHover
                    : widget.background,
            borderRadius: widget.borderRadius,
            border: Border.all(
              color: _isPressed
                  ? widget.borderColorPressed
                  : _isHovering
                      ? widget.borderColorHover
                      : widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: _isPressed
                  ? widget.splashColorPressed
                  : _isHovering
                  ? widget.splashColorPressed
                  : widget.splashColor,
              borderRadius: widget.borderRadius! * 0.5,
            ),
            child: SvgPicture.string(
              _isPressed
                  ? widget.svgIconPressed
                  : _isHovering
                      ? widget.svgIconHover
                      : widget.svgIcon,
              colorFilter: ColorFilter.mode(
                _isPressed
                    ? widget.iconColorPressed
                    : _isHovering
                        ? widget.iconColorHover
                        : widget.iconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
