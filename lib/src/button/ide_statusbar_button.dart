import 'package:flutter/material.dart';
import 'package:idea/src/visibility/ide_visibility_builder.dart';

class IdeStatusbarButton extends StatelessWidget {
  final bool borderLeft;
  final bool borderRight;
  final IconData? icon;
  final double width;
  final double minWidth;
  final String? label;
  final String? tooltip;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const IdeStatusbarButton({
    super.key,
    this.borderLeft = false,
    this.borderRight = false,
    this.icon,
    this.label,
    this.tooltip,
    required this.width,
    this.minWidth = 22,
    required this.onPressed,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        hoverColor: Colors.blueAccent.withValues(alpha: 0.3),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minWidth: minWidth),
          padding: padding,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.transparent,
            border: Border(
              left: BorderSide(width: borderLeft ? 1.0 : 0, color: Colors.black12),
              right: BorderSide(width: borderRight ? 1.0 : 0, color: Colors.black12),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IdeVisibilityBuilder(
                condition: icon != null,
                child: () => Container(
                  alignment: Alignment.center,
                  width: 18,
                  child: Icon(
                    icon ?? Icons.check_box_outline_blank,
                    color: Colors.black.withValues(alpha: 0.6),
                    size: 19,
                  ),
                ),
              ),
              IdeVisibilityBuilder(
                condition: label != null,
                child: () => const Padding(
                  padding: EdgeInsets.only(top: 3, left: 3, right: 3),
                  child: Text(
                    'xx',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
