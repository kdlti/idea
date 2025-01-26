import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/table/src/row/ide_table_row_text.dart';

class IdeTableRowRender extends StatelessWidget {
  final List<IdeTableColumn> dataColumns;
  final IdeTableRowStyle? rowStyle;
  final bool checkboxShow;
  final Map<String, dynamic> data;
  final VoidCallback onRowClickSelected;
  final VoidCallback onRowDoubleClickSelected;
  final Function(Map<String, dynamic> value, IdeTableColumn header)? onChangedRow;
  final Function(Map<String, dynamic> value, IdeTableColumn header)? onSubmittedRow;
  final List<Map<String, dynamic>>? dataSelecteds;
  final IdeTableHeader header;
  final ValueChanged<bool?>? onChanged;
  final IdeTableRowSelectedStyle? rowSelectedStyle;
  final IdeTableRowHoverStyle? rowHoverStyle;
  final IdeTableRowCheckedStyle? rowCheckedStyle;
  final IdeTableExpandedRowStyle? rowExpandedStyle;
  final bool isSelected;
  final bool isChecked;
  final bool isExpanded;
  final bool hasExpanded;
  final IdeTableCellStyle? cellStyle;

  IdeTableRowRender({
    super.key,
    required this.dataColumns,
    required this.checkboxShow,
    required this.data,
    required this.onRowClickSelected,
    required this.onRowDoubleClickSelected,
    required this.onChangedRow,
    required this.onSubmittedRow,
    required this.header,
    required this.dataSelecteds,
    required this.onChanged,
    required this.isSelected,
    required this.isChecked,
    required this.isExpanded,
    required this.hasExpanded,
    this.cellStyle,
    this.rowStyle,
    this.rowCheckedStyle,
    this.rowHoverStyle,
    this.rowSelectedStyle,
    this.rowExpandedStyle,
  });

  //========================================
  // isHover
  //========================================
  final RxBool _isHover = false.obs;

  set isHover(bool value) => _isHover.value = value;

  bool get isHover => _isHover.value;

  BoxDecoration? getDecoration(
    BoxDecoration? rowStyleDecoration,
    BoxDecoration? rowHoverStyleDecoration,
    BoxDecoration? rowSelectedStyleDecoration,
    BoxDecoration? rowCheckedStyleDecoration,
    BoxDecoration? rowExpandedStyleDecoration,
  ) {
    BoxDecoration? decoration = rowStyleDecoration;

    if (isHover) {
      decoration = rowHoverStyleDecoration;
    }

    if (isSelected && !hasExpanded) {
      decoration = rowSelectedStyleDecoration;
    }
    if (isChecked) {
      decoration = rowCheckedStyleDecoration;
    }

    if (isExpanded) {
      decoration = rowExpandedStyleDecoration;
    }

    return decoration;
  }

  TextStyle? getTextStyle(
    TextStyle rowStyleText,
    TextStyle rowHoverStyleText,
    TextStyle rowSelectedStyleText,
    TextStyle rowCheckedStyleStyleText,
    TextStyle rowExpandedStyleText,
  ) {
    TextStyle? textStyle = rowStyleText;

    if (isHover) {
      textStyle = rowHoverStyleText;
    }

    if (isSelected && !hasExpanded) {
      textStyle = rowSelectedStyleText;
    }
    if (isChecked) {
      textStyle = rowCheckedStyleStyleText;
    }

    if (isExpanded) {
      textStyle = rowExpandedStyleText;
    }
    return textStyle;
  }

  EdgeInsetsGeometry? getMargin(
    EdgeInsetsGeometry? rowStyleMargin,
    EdgeInsetsGeometry? rowExpandedStyleMargin,
  ) {
    EdgeInsetsGeometry? margin;
    if (isExpanded) {
      margin = rowExpandedStyleMargin;
    } else {
      margin = rowStyleMargin;
    }
    return margin;
  }

  @override
  Widget build(BuildContext context) {
    final IdeTableRowStyle themeRowStyle = Theme.of(context).extension<IdeTableRowStyle>()!;
    final EdgeInsetsGeometry? rowStylePadding = rowStyle?.padding ?? themeRowStyle.padding;
    final EdgeInsetsGeometry? rowStyleMargin = rowStyle?.margin ?? themeRowStyle.margin;
    final BoxDecoration? rowStyleDecoration = rowStyle?.decoration ?? themeRowStyle.decoration;
    final TextStyle rowStyleText = rowStyle?.text! ?? themeRowStyle.text!;
    final CrossAxisAlignment crossAxisAlignment = rowStyle?.crossAxisAlignment! ?? themeRowStyle.crossAxisAlignment!;

    final IdeTableExpandedRowStyle themeRowExpandedStyle = Theme.of(context).extension<IdeTableExpandedRowStyle>()!;
    final EdgeInsetsGeometry? rowExpandedStyleMargin = rowExpandedStyle?.margin ?? themeRowExpandedStyle.margin;
    final BoxDecoration? rowExpandedStyleDecoration = rowExpandedStyle?.decoration ?? themeRowExpandedStyle.decoration;
    final TextStyle rowExpandedStyleText = rowExpandedStyle?.text! ?? themeRowExpandedStyle.text!;

    final IdeTableRowHoverStyle themeRowHoverStyle = Theme.of(context).extension<IdeTableRowHoverStyle>()!;
    final BoxDecoration? rowHoverStyleDecoration = rowHoverStyle?.decoration ?? themeRowHoverStyle.decoration;
    final TextStyle rowHoverStyleText = rowHoverStyle?.text! ?? themeRowHoverStyle.text!;

    final IdeTableRowSelectedStyle themeRowSelectedStyle = Theme.of(context).extension<IdeTableRowSelectedStyle>()!;
    final BoxDecoration? rowSelectedStyleDecoration = rowSelectedStyle?.decoration ?? themeRowSelectedStyle.decoration;
    final TextStyle rowSelectedStyleText = rowSelectedStyle?.text! ?? themeRowSelectedStyle.text!;

    final IdeTableRowCheckedStyle themeRowCheckedStyle = Theme.of(context).extension<IdeTableRowCheckedStyle>()!;
    final BoxDecoration? rowCheckedStyleDecoration = rowCheckedStyle?.decoration ?? themeRowCheckedStyle.decoration;
    final TextStyle rowCheckedStyleStyleText = rowCheckedStyle?.text! ?? themeRowCheckedStyle.text!;

    return Obx(
      () => Container(
        margin: getMargin(rowStyleMargin, rowExpandedStyleMargin),
        decoration: getDecoration(
            rowStyleDecoration, rowHoverStyleDecoration, rowSelectedStyleDecoration, rowCheckedStyleDecoration, rowExpandedStyleDecoration),
        child: ClipRRect(
          borderRadius: rowStyleDecoration?.borderRadius! != null ? rowStyleDecoration!.borderRadius! : BorderRadius.zero,
          child: InkWell(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            onHover: (value) {
              isHover = value;
            },
            onTap: onRowClickSelected,
            onDoubleTap: onRowDoubleClickSelected,
            child: Container(
              padding: rowStylePadding,
              decoration: getDecoration(
                rowStyleDecoration,
                rowHoverStyleDecoration,
                rowSelectedStyleDecoration,
                rowCheckedStyleDecoration,
                rowExpandedStyleDecoration,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  if (checkboxShow && dataSelecteds != null)
                    Checkbox(
                      splashRadius: 0,
                      value: dataSelecteds!.contains(data),
                      onChanged: onChanged,
                    ),
                  ...dataColumns.where((column) => column.visible == true).map(
                    (column) {
                      if (column.constraint != null) {
                        return IntrinsicWidth(
                          child: Container(
                            constraints: column.constraint,
                            child: IdeTableRowText(
                              data: data,
                              header: column,
                              cellStyle: cellStyle,
                              onChangedRow: onChangedRow,
                              onSubmittedRow: onSubmittedRow,
                              onTap: onRowClickSelected,
                              style: getTextStyle(
                                rowStyleText,
                                rowHoverStyleText,
                                rowSelectedStyleText,
                                rowCheckedStyleStyleText,
                                rowExpandedStyleText,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          flex: column.flex,
                          child: IdeTableRowText(
                            data: data,
                            header: column,
                            cellStyle: cellStyle,
                            onChangedRow: onChangedRow,
                            onSubmittedRow: onSubmittedRow,
                            onTap: onRowClickSelected,
                            style: getTextStyle(
                              rowStyleText,
                              rowHoverStyleText,
                              rowSelectedStyleText,
                              rowCheckedStyleStyleText,
                              rowExpandedStyleText,
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
