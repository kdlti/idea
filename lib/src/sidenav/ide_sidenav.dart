import 'package:flutter/material.dart';
import 'package:idea/package.dart';

enum IdeSidenavObserverType { content, rightPanel }

class IdeSidenav extends StatelessWidget {
  final List<IdeSidenavItem>? children;
  final bool allowMultipleOpen;

  IdeSidenav({
    super.key,
    this.children,
    this.allowMultipleOpen = false,
  }){
    Ide.sidenavManager.allowMultipleOpen = allowMultipleOpen ;
  }

  //========================================
  // scrollToSelectedContent
  //========================================
  final ScrollController _scrollController = ScrollController();

  void _scrollToSelectedContent(bool isExpanded, double previousOffset, int index) {
    _scrollController.animateTo(isExpanded ? (35.0 * index) : previousOffset,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  //========================================
  // buildContent
  //========================================
  Widget _buildContent(BoxConstraints constraints) {
    double previousOffset = 0;

    return ListView.builder(
      controller: _scrollController,
      itemCount: children!.length,
      itemBuilder: (context, index) {
        IdeSidenavItem button = children![index];
        if (button.subitems != null) {
          button.onExpansionChanged = (isExpanded, callback) {
            callback();
            if (isExpanded) previousOffset = _scrollController.offset;
            _scrollToSelectedContent(isExpanded, previousOffset, index);
          };
        }
        return button;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          alignment: Alignment.topLeft,
          width: constraints.maxWidth,
          child: _buildContent(constraints),
        );
      },
    );
  }
}
