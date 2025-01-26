import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeTableColumn {
  final String text;
  final String value;
  final bool sortable;
  final bool editable;
  final bool visible;
  final TextAlign textAlign;
  final int flex;
  final Widget Function(dynamic value)? headerBuilder;
  final Widget Function(dynamic value)? footerBuilder;
  final Widget Function(dynamic value, Map<String?, dynamic> row)? dataBuilder;
  final bool search;
  final BoxConstraints? constraint;
  bool sortAscending = true;

  late IdeTableHeaderConfig? config;

  IdeTableColumn({
    required this.text,
    required this.value,
    this.textAlign = TextAlign.left,
    this.sortable = true,
    this.search = true,
    this.visible = true,
    this.editable = false,
    this.flex = 1,
    this.headerBuilder,
    this.footerBuilder,
    this.dataBuilder,
    this.config,
    this.constraint,
  });

  factory IdeTableColumn.fromMap(Map<String, dynamic> map) => IdeTableColumn(
        text: map['text'],
        value: map['value'],
        sortable: map['sortable'],
        visible: map['visible'],
        textAlign: map['textAlign'],
        flex: map['flex'],
        headerBuilder: map['headerBuilder'],
        dataBuilder: map['dataBuilder'],
        config: map['config'],
        constraint: map['constraint'],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "value": value,
        "sortable": sortable,
        "visible": visible,
        "textAlign": textAlign,
        "flex": flex,
        "headerBuilder": headerBuilder,
        "dataBuilder": dataBuilder,
        "constraint": constraint,
      };

  @override
  String toString() {
    return 'IdeTableColumn{text: $text, value: $value, sortable: $sortable, editable: $editable, visible: $visible, textAlign: $textAlign, flex: $flex, headerBuilder: $headerBuilder, footerBuilder: $footerBuilder, dataBuilder: $dataBuilder, search: $search, constraint: $constraint, sortAscending: $sortAscending, config: $config}';
  }
}
