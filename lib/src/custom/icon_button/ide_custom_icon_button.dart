import 'package:flutter/material.dart';
import 'package:idea/src/custom/icon_button/ide_custom_icon_button_decoration.dart';

class IdeCustomIconButton extends StatefulWidget {
  final IconData icon;
  final double width;
  final double height;
  final IdeIconButtonDecoration decoration;
  final VoidCallback? onPressed;

  const IdeCustomIconButton({
    super.key,
    this.icon = Icons.add,
    this.width = 24,
    this.height = 24,
    this.onPressed,
    this.decoration = const IdeIconButtonDecoration(),
  });

  @override
  IdeCustomIconButtonState createState() => IdeCustomIconButtonState();
}

class IdeCustomIconButtonState extends State<IdeCustomIconButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click, // Muda o cursor para o estilo de clique
        child: Opacity(
          opacity: widget.onPressed != null ? 1 : 0.5, // Muda a opacidade do ícone no hover
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(widget.decoration.borderRadius),
              child: InkWell(
                onTap: widget.onPressed,
                child: Container(
                  padding: widget.decoration.padding,
                  margin: widget.decoration.margin,
                  decoration: BoxDecoration(
                    //color: _isHovering ? widget.decoration.colorHover : widget.decoration.color, // Muda a cor do ícone no hover
                    borderRadius: BorderRadius.circular(widget.decoration.borderRadius),
                  ),
                  child: Icon(
                    widget.icon,
                    size: widget.decoration.iconSize,
                    color: _isHovering ? widget.decoration.iconColorHover : widget.decoration.iconColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
