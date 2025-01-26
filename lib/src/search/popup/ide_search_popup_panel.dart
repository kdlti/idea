import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:idea/src/search/popup/ide_search_popup_header.dart';
import 'package:idea/src/search/popup/ide_search_popup_item.dart';

class IdeSearchPopupPanel extends StatefulWidget {
  final String? title;
  final String? message;
  final bool? showCloseButton;
  final List<IdeSearchPopupItem> children;
  final VoidCallback onChanged;
  final double width;
  final headerHeight = 17.0;

  const IdeSearchPopupPanel({
    super.key,
    required this.children,
    required this.onChanged,
    this.title,
    this.message,
    this.showCloseButton = true,
    this.width = 230,
  });

  @override
  State<IdeSearchPopupPanel> createState() => _IdeSearchPopupPanelState();
}

class _IdeSearchPopupPanelState extends State<IdeSearchPopupPanel> {
  int? _hoveredIndex;
  bool showError = false;

  int countSelected() {
    int totalSelected = 0;
    for (var item in widget.children) {
      if (item.selected) {
        totalSelected++;
      }
    }
    return totalSelected;
  }

  double getHeight() {
    double headerHeight = (widget.title != null || widget.showCloseButton == true) ? (widget.headerHeight+8) : 0;
    double messageHeight = (widget.message != null) ? 15 : 0;
    return (widget.children.length * 30) + (headerHeight + messageHeight);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(),
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null || widget.showCloseButton == true)
            IdeSearchPopupHeader(
              title: widget.title,
              showCloseButton: widget.showCloseButton,
              height: widget.headerHeight,
            ),
          if (widget.title != null || widget.showCloseButton == true) const SizedBox(height: 8),
          SizedBox(
            height: (widget.children.length * 30),
            child: ListView.builder(
              itemCount: widget.children.length,
              itemBuilder: (BuildContext context, int index) {
                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _hoveredIndex = index;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _hoveredIndex = null;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        print('${widget.children[index]}');
                        widget.children[index].selected = !widget.children[index].selected;
                      });
                      showError = false;
                      if (countSelected() <= 0) {
                        setState(() {
                          widget.children[index].selected = true;
                          showError = true;
                        });
                      }

                      widget.onChanged();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: _hoveredIndex == index ? Colors.grey[200] : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SizedBox(
                        height: 25,
                        child: Row(
                          children: [
                            if (widget.children[index].icon != null) // Mostrar o ícone apenas se fornecido
                              Icon(
                                widget.children[index].icon,
                                color: Colors.grey,
                                size: 18,
                              ),
                            if (widget.children[index].icon != null) const SizedBox(width: 5), // Espaçamento entre o ícone e o texto
                            Expanded(
                              child: Text(
                                widget.children[index].label,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              height: 14,
                              child: FlutterSwitch(
                                width: 25,
                                height: 14,
                                valueFontSize: 10,
                                toggleSize: 11,
                                value: widget.children[index].selected,
                                padding: 1,
                                activeColor: Colors.green,
                                onToggle: (val) {
                                  setState(() {
                                    widget.children[index].selected = val;
                                  });
                                  showError = false;
                                  if (countSelected() <= 0) {
                                    setState(() {
                                      widget.children[index].selected = true;
                                      showError = true;
                                    });
                                  }
                                  widget.onChanged();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.message != null)
            SizedBox(
              height: 15,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(widget.message!, style: TextStyle(fontSize: 10, color: showError ? Colors.red : Colors.grey[400])),
              ),
            ),
        ],
      ),
    );
  }
}
