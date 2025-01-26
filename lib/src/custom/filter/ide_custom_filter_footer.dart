import 'package:flutter/material.dart';

class IdeCustomFilterFooter extends StatefulWidget {
  final VoidCallback onPressed;

  const IdeCustomFilterFooter({super.key, required this.onPressed});

  @override
  State<IdeCustomFilterFooter> createState() => _IdeCustomFilterFooterState();
}

class _IdeCustomFilterFooterState extends State<IdeCustomFilterFooter> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: InkWell(
            onHover: (hovering) {
              setState(() => isHovering = hovering);
            },
            onTap: widget.onPressed,
            child: AnimatedContainer(
              height: 28,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 5),
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isHovering ? Colors.black.withValues(alpha: 0.08) : Colors.transparent,
                border: Border.all(color: Colors.black26, width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: const Icon(Icons.add, size: 18),
                  ),
                  const Text(
                    'Adicionar Filtro',
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
