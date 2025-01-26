import 'package:flutter/material.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/submenu/ide_submenu_item_render.dart';

class IdeSubmenuBoxRender extends StatelessWidget {
  final double width;
  final List<IdeMenuAbastract> children;
  final double minWidth;
  final double maxWidth;

  const IdeSubmenuBoxRender({
    required this.children,
    required this.width,
    this.minWidth = 28,
    this.maxWidth = 300,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> listItems = [];
    int len = children.length;
    for (int i = 0; i < len; i++) {
      dynamic submenuItem = children[i];
      if (submenuItem.divider) {
        listItems.add(const Divider(
          height: 5,
        ));
      }
      listItems.add(IdeSubmenuItemRender(index: i, submenuItem: submenuItem, width: width));
    }

    return Container(
      width: width,
      padding: const EdgeInsets.all(0),
      constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.4),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        child: Column(
          children: listItems,
        ),
      ),
    );
  }
}
