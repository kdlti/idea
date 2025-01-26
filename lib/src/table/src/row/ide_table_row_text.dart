import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/table/src/ide_table_editable.dart';

class IdeTableRowText extends StatefulWidget {
  final IdeTableColumn header;
  final Map<String, dynamic> data;
  final Function(Map<String, dynamic> value, IdeTableColumn header)? onChangedRow;
  final Function(Map<String, dynamic> value, IdeTableColumn header)? onSubmittedRow;
  final VoidCallback? onTap;
  final TextStyle? style;
  final IdeTableCellStyle? cellStyle;

  const IdeTableRowText({
    super.key,
    required this.header,
    required this.data,
    required this.onChangedRow,
    required this.onSubmittedRow,
    this.cellStyle,
    this.onTap,
    this.style,
  });

  @override
  State<IdeTableRowText> createState() => _IdeTableRowRenderState();
}

class _IdeTableRowRenderState extends State<IdeTableRowText> {
  bool isEditabled = false;

  @override
  Widget build(BuildContext context) {
    final IdeTableCellStyle themeCellStyle = Theme.of(context).extension<IdeTableCellStyle>()!;
    final EdgeInsetsGeometry? cellStylePadding = widget.cellStyle?.padding ?? themeCellStyle.padding;
    final EdgeInsetsGeometry? cellStyleMargin = widget.cellStyle?.margin ?? themeCellStyle.margin;
    final BoxDecoration? cellStyleDecoration = widget.cellStyle?.decoration ?? themeCellStyle.decoration;
    final TextAlign cellStyleTextAlign = widget.cellStyle?.textAlign ?? themeCellStyle.textAlign!;
    final TextOverflow cellStyleOverflow = widget.cellStyle?.overflow ?? themeCellStyle.overflow!;
    final int cellStyleMaxLines = widget.cellStyle?.maxLines ?? themeCellStyle.maxLines!;

    return widget.header.dataBuilder != null
        ? widget.header.dataBuilder!(widget.data[widget.header.value], widget.data)
        : widget.header.editable && isEditabled
            ? IdeTableEditable(
                data: widget.data,
                header: widget.header,
                textAlign: widget.header.textAlign,
                onChanged: widget.onChangedRow,
                onSubmitted: widget.onSubmittedRow,
                onEditingComplete: () {
                  setState(() {
                    isEditabled = false;
                  });
                },
              )
            : InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                canRequestFocus: false,
                onTap: widget.onTap,
                onLongPress: () {
                  setState(() {
                    isEditabled = true;
                  });
                },
                child: Container(
                  padding: cellStylePadding,
                  margin: cellStyleMargin,
                  decoration: cellStyleDecoration,
                  child: Text(
                    "${widget.data[widget.header.value]} ",
                    textAlign: cellStyleTextAlign,
                    style: widget.style,
                    maxLines: cellStyleMaxLines,
                    overflow: cellStyleOverflow,
                  ),
                ),
              );
  }
}
