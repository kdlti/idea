import 'package:flutter/material.dart';

class IdeExpandsItem {
  final Widget header;
  final Widget body;
  final bool isExpanded;

  IdeExpandsItem({
    required this.header,
    required this.body,
    this.isExpanded = false,
  });
}
