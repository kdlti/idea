import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_item_render.dart';

// ignore: must_be_immutable
class IdeMenuBoxRender extends StatelessWidget {
  final double width;
  final List<IdeMenuAbastract> children;
  final double minWidth;
  final double maxWidth;
  double menuWidth = 0;
  double height;
  double menuBoxHeight = 0;
  BorderRadiusGeometry? borderRadius;
  List<Widget> listItems = [];

  IdeMenuBoxRender({
    super.key,
    required this.children,
    required this.width,
    this.height = 0,
    this.minWidth = 28,
    this.maxWidth = 300,
    this.borderRadius = const BorderRadius.only(
      topRight: Radius.circular(8),
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8),
    ),
  }) {
    menuWidth = width;
    if (width > maxWidth) {
      menuWidth = maxWidth;
    } else if (width < minWidth) {
      menuWidth = minWidth;
    }

    int len = children.length;

    double countDivider = 0;
    for (int i = 0; i < len; i++) {
      dynamic menu = children[i];
      if (menu.divider) {
        listItems.add(const Divider(height: 1));
        countDivider++;
      }
      if (width > 50 || (width <= 50 && menu.icon != null)) {
        listItems.add(IdeMenuItemRender(index: i, menu: menu, width: menuWidth));
      }
    }
    height = (len * 24) + countDivider;
  }

  @override
  Widget build(BuildContext context) {
    menuBoxHeight = height + 2;
    if (height > Get.height) {
      menuBoxHeight = Get.height - 1;
    }

    return Container(
      padding: const EdgeInsets.all(0),
      width: menuWidth,
      height: menuBoxHeight,
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
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius!,
        child: IdeVisibilityToggle(
          condition: height > menuBoxHeight,
          firstChild: () => ListView(
            children: [
              SizedBox(
                height: height,
                child: Column(
                  children: listItems,
                ),
              )
            ],
          ),
          secondChild: () => SizedBox(
            height: height,
            child: Column(
              children: listItems,
            ),
          ),
        ),
      ),
    );
  }
}
