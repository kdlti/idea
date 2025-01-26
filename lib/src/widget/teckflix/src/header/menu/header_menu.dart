import 'package:flutter/material.dart';
import 'package:idea/src/widget/teckflix/package.dart';

enum HeaderMenuIndicatorType { text, boxColor }

class HeaderMenu extends StatefulWidget {
  final List<HeaderMenuItem> items;
  final HeaderMenuItem selectedItem;
  final Color indicatorColor;
  final HeaderMenuIndicatorType indicatorType;
  final ValueChanged<HeaderMenuItem> onClick;
  final TextStyle? textStyle;
  final BoxDecoration? decoration;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? gap;

  const HeaderMenu({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.indicatorColor,
    required this.indicatorType,
    required this.onClick,
    this.textStyle = const TextStyle(fontSize: 14),
    this.decoration,
    this.height,
    this.padding,
    this.margin,
    this.gap = 20,
  });

  @override
  State<HeaderMenu> createState() => _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenu> with SingleTickerProviderStateMixin {
  int? hoveredIndex;
  late HeaderMenuItem selectedItem;
  late AnimationController _controller;
  late Animation<double> _indicatorWidth;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calculateTotalWidth() {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double totalWidth = 0.0;

    for (var item in widget.items) {
      textPainter.text = TextSpan(text: item.label, style: widget.textStyle);
      textPainter.layout();
      totalWidth += textPainter.width;
      item.width = textPainter.width;
    }

    // Add gap between items
    if (widget.items.length > 1) {
      totalWidth += widget.gap! * (widget.items.length - 1);
    }

    return totalWidth;
  }

  void _onItemTapped(HeaderMenuItem item) {
    setState(() {
      selectedItem = item;
    });
    _controller.reset();
    _controller.forward();
    widget.onClick(item);
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = _calculateTotalWidth();

    return Container(
      padding: widget.padding,
      margin: widget.margin,
      decoration: widget.decoration,
      width: totalWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          final isSelected = item.value == selectedItem.value;
          final isHovered = hoveredIndex == index;
          _indicatorWidth = Tween<double>(begin: 0, end: (selectedItem.width ?? 30) * 0.5).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          );

          return GestureDetector(
            onTap: () {
              _onItemTapped(item);
            },
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  hoveredIndex = index;
                });
              },
              onExit: (_) {
                setState(() {
                  hoveredIndex = null;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.label,
                    style: widget.textStyle?.copyWith(
                      color: isSelected
                          ? widget.indicatorColor
                          : isHovered
                              ? widget.indicatorColor.withValues(alpha: 0.7)
                              : Colors.green,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        height: isSelected ? 3 : 0,
                        width: _indicatorWidth.value,
                        decoration: BoxDecoration(
                          color: widget.indicatorColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
