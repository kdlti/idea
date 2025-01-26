import 'package:idea/src/table/package.dart';

class IdeTableStyle {
  final IdeTableRowStyle? row;
  final IdeTableRowHoverStyle? rowHover;
  final IdeTableRowSelectedStyle? rowSelected;
  final IdeTableExpandedRowStyle? expandedRow;
  final IdeTableRowCheckedStyle? rowChecked;
  final IdeTableCellStyle? cell;

  IdeTableStyle({
    this.row,
    this.rowHover,
    this.rowSelected,
    this.rowChecked,
    this.expandedRow,
    this.cell,
  });
}
