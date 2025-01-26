import 'package:flutter/material.dart';

class IdeMenubarTopButtonClose extends StatefulWidget {
  final double? size;
  final VoidCallback? onPressed;

  const IdeMenubarTopButtonClose({
    super.key,
    this.size,
    required this.onPressed,
  });

  @override
  State<IdeMenubarTopButtonClose> createState() => _IdeMenubarTopButtonCloseState();
}

class _IdeMenubarTopButtonCloseState extends State<IdeMenubarTopButtonClose> {
  bool isHoverClose = false;

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = Colors.yellow;
    final Color? iconHoverColor = Colors.red;
    final double? iconCloseSize = widget.size;

    return SizedBox(
      width: iconCloseSize,
      height: iconCloseSize,
      child: CircleAvatar(
        backgroundColor: isHoverClose ? iconHoverColor : Colors.transparent,
        child: InkWell(
          onHover: (value) {
            setState(() {
              isHoverClose = value;
            });
          },
          onTap: widget.onPressed,
          child: Icon(
            Icons.clear,
            size: iconCloseSize! * 0.75,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
