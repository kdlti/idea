import 'package:flutter/material.dart';

class IdeSearchPopupIcon extends StatefulWidget {
  const IdeSearchPopupIcon({super.key});

  @override
  IdeSearchPopupIconState createState() => IdeSearchPopupIconState();
}

class IdeSearchPopupIconState extends State<IdeSearchPopupIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click, // Muda o cursor para o estilo de clique
        child: Container(
          decoration: BoxDecoration(
            color: _isHovering ? Colors.black.withValues(alpha: 0.1) : Colors.transparent, // Muda a cor do ícone no hover
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Icon(
            Icons.more_horiz_rounded,
            size: 16,
          ),
        ),
      ),
    );
  }
}
