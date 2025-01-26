import 'package:flutter/material.dart';
import 'package:idea/src/expands/src/ide_expands_item.dart';

import 'ide_expands_panel.dart';

class IdeExpands extends StatefulWidget {
  final List<IdeExpandsItem> children;

  /// Whether tapping on the panel's header will expand/collapse it.
  ///
  /// Defaults to false.
  final bool canTapOnHeader;

  const IdeExpands({
    super.key,
    required this.children,
    this.canTapOnHeader = true,
  });

  @override
  _IdeExpandsState createState() => _IdeExpandsState();
}

class _IdeExpandsState extends State<IdeExpands> with SingleTickerProviderStateMixin {
  late List<bool> _isOpenList;

  @override
  void initState() {
    super.initState();
    _isOpenList = List<bool>.filled(widget.children.length, false);

    for (int i = 0; i < widget.children.length; i++) {
      _isOpenList[i] = widget.children[i].isExpanded;
      print('widget.children[i].isExpanded: ${widget.children[i].isExpanded}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: IdeExpandsPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isOpenList[index] = !isExpanded;
            //TODO:: Finalizar implementação do IdeExpands
            if (_isOpenList[index]) {
            } else {}
          });
        },
        children: List.generate(
          widget.children.length,
          (index) => IdeExpandsPanel(
            backgroundColor: Colors.white,
            isExpanded: _isOpenList[index],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return widget.children[index].header;
            },
            body: widget.children[index].body,
          ),
        ),
        dividerColor: Colors.grey[200],
      ),
    );
  }
}
