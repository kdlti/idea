import 'package:flutter/material.dart';

class IdeSwitchListOption<T> {
  final String title;
  final String? subTitle;
  final Icon? icon;
  final bool enabled;
  final String id;
  T value;

  IdeSwitchListOption({
    required this.title,
    this.subTitle,
    required this.value,
    this.icon,
    this.enabled = true,
    this.id = "",
  });

  @override
  String toString() {
    return 'Instance of LabelValue(title:$title, subTitle:$subTitle, value:$value, icon:$icon, enabled:$enabled, id:$id)';
  }
}
