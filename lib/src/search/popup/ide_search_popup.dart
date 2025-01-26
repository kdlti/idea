import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/search/popup/ide_search_popup_icon.dart';
import 'package:idea/src/search/popup/ide_search_popup_item.dart';
import 'package:idea/src/search/popup/ide_search_popup_panel.dart';

class IdeSearchPopup extends StatelessWidget {
  final String? title;
  final String? message;
  final double width;
  final bool? showCloseButton;
  final List<IdeSearchPopupItem> children;
  final VoidCallback onChanged;

  const IdeSearchPopup({
    super.key,
    required this.children,
    required this.onChanged,
    this.title,
    this.message,
    this.showCloseButton = true,
    this.width = 230,
  });

  @override
  Widget build(BuildContext context) {
    return IdeCustomPopup(
      showArrow: true,
      content: IdeSearchPopupPanel(
        children: children,
        title: title,
        onChanged: onChanged,
        message: message,
        showCloseButton: showCloseButton,
        width: width,
      ),
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      arrowColor: Colors.white,
      child: const IdeSearchPopupIcon(),
    );
  }
}
