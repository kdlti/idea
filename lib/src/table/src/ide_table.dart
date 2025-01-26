import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/table/package.dart';
import 'package:idea/src/table/src/ide_table_controller.dart';
import 'package:idea/src/table/src/row/ide_table_row_render.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class IdeTable extends StatefulWidget {
  final bool checkboxShow;
  final List<Map<String, dynamic>> dataSource;
  final List<IdeTableColumn> dataColumns;
  final List<Map<String, dynamic>>? dataSelecteds;
  final Function(bool? value)? onSelectAll;
  final Function(bool? value, Map<String, dynamic> data)? onCheckboxSelected;
  final Function(Map<String, dynamic> value, int index)? onRowClickSelected;
  final Function(Map<String, dynamic> value, int index)? onRowDoubleClickSelected;
  final VoidCallback? onSort;
  final bool autoHeight;
  final IdeTableExpandedPanel? expandedPanel;
  final Function(Map<String, dynamic> value, IdeTableColumn header)? onChangedRow;
  final Function(Map<String, dynamic> value, IdeTableColumn header)? onSubmittedRow;
  final double? minWidth;
  final double? maxHeight;

  final IdeTableHeader header;
  final IdeTableSearch? search;
  final IdeTableFooter? footer;
  final IdeTablePaginator? paginator;
  final IdeTableController controller;

  final IdeTableStyle? style;

  const IdeTable({
    super.key,
    required this.header,
    required this.controller,
    this.search,
    this.footer,
    this.checkboxShow = false,
    this.onSelectAll,
    this.onCheckboxSelected,
    this.onRowClickSelected,
    this.onRowDoubleClickSelected,
    this.onSort,
    required this.dataSource,
    required this.dataColumns,
    this.dataSelecteds = const [],
    this.autoHeight = false,
    this.expandedPanel,
    this.onChangedRow,
    this.onSubmittedRow,
    this.minWidth,
    this.maxHeight,
    this.paginator,
    this.style,
  });

  @override
  State<IdeTable> createState() => _IdeTableState();

  // Recebe uma lista de dados e formata a lista adicionando um índice a cada item.
  // TODO:: Remover este método.
  static Future<List<Map<String, dynamic>>> formatData({required List<dynamic> apiResult, bool addIndex = false}) async {
    int index = 1;
    List<Map<String, dynamic>> data = [];
    if(apiResult.isNotEmpty) {
      for (var item in apiResult) {
        Map<String, dynamic> itemData = item;
        if (addIndex) {
          itemData["index"] = index;
          index++;
        }
        data.add(itemData);
      }
    }
    return data;
  }
}

class _IdeTableState extends State<IdeTable> {
  final Map<int, bool> listSelected = {};
  int selectedIndex = -1;
  String activeSortColumn = "";
  dynamic selectedItem;

  @override
  initState() {
    Ide.tableRowDataSelected = null;
    super.initState();
  }

  static Alignment headerAlignSwitch(TextAlign? textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.right:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  void onRowClickSelected(data, index) {
    Ide.tableRowDataSelected = data;
    widget.onRowClickSelected?.call(data, index);
    if (widget.expandedPanel != null) {
      widget.expandedPanel!.expandedList[index] = !widget.expandedPanel!.expandedList[index];
    }

    listSelected[index] = true;
    selectedItem = data;
    /*if (listSelected[index]!) {
      if (selectedItem == data) {
        selectedItem = null;
      } else {
        selectedItem = data;
      }
    }*/
    setState(() {});
  }

  void onRowDoubleClickSelected(data, index) {
    Ide.tableRowDataSelected = data;
    widget.onRowDoubleClickSelected?.call(data, index);
    listSelected[index] = true;
    selectedItem = data;
    setState(() {});
  }

  Widget buildHeader() {
    IdeTableHeader header = widget.header;

    return Container(
      padding: header.padding,
      margin: header.margin,
      decoration: header.decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.checkboxShow && widget.dataSelecteds != null)
            Checkbox(
              splashRadius: 0,
              value: widget.dataSelecteds!.length == widget.dataSource.length && widget.dataSource.isNotEmpty,
              onChanged: (value) {
                if (widget.onSelectAll != null) widget.onSelectAll!(value);
              },
            ),
          ...widget.dataColumns.where((header) => header.visible == true).map(
            (column) {
              IdeTableHeaderConfig headerConfig = header.config!;
              if (column.config != null) {
                headerConfig = column.config!;
              }

              if (column.constraint != null) {
                return IntrinsicWidth(
                  child: Container(
                    constraints: column.constraint,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      canRequestFocus: false,
                      onTap: () {
                        if (widget.onSort != null && column.sortable) {
                          if (widget.controller.sort.field != "" && widget.controller.sort.sortAscending) {
                            activeSortColumn = "";
                            widget.controller.sort.field = "";
                          } else {
                            column.sortAscending = !column.sortAscending;
                            widget.controller.sort.field = column.value;
                            widget.controller.sort.sortAscending = column.sortAscending;
                            activeSortColumn = column.value;
                          }
                          widget.onSort!();
                        }
                      },
                      child: column.headerBuilder != null
                          ? column.headerBuilder!(column.value)
                          : Container(
                              padding: headerConfig.padding,
                              margin: headerConfig.margin,
                              alignment: headerAlignSwitch(column.textAlign),
                              decoration: BoxDecoration(
                                color: (activeSortColumn == column.value) ? headerConfig.color : Colors.transparent,
                                borderRadius: headerConfig.borderRadius,
                                border: headerConfig.border,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      column.text,
                                      textAlign: headerConfig.textAlign,
                                      style: (activeSortColumn == column.value) ? headerConfig.styleSelected : headerConfig.style,
                                    ),
                                  ),
                                  if (activeSortColumn == column.value)
                                    column.sortAscending ? headerConfig.iconDescending : headerConfig.iconAscending,
                                ],
                              ),
                            ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  flex: column.flex,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    canRequestFocus: false,
                    onTap: () {
                      if (widget.onSort != null && column.sortable) {
                        if (widget.controller.sort.field != "" && widget.controller.sort.sortAscending) {
                          activeSortColumn = "";
                          widget.controller.sort.field = "";
                        } else {
                          column.sortAscending = !column.sortAscending;
                          widget.controller.sort.field = column.value;
                          widget.controller.sort.sortAscending = column.sortAscending;
                          activeSortColumn = column.value;
                        }
                        widget.onSort!();
                      }
                    },
                    child: column.headerBuilder != null
                        ? column.headerBuilder!(column.value)
                        : Container(
                            padding: headerConfig.padding,
                            margin: headerConfig.margin,
                            alignment: headerAlignSwitch(column.textAlign),
                            decoration: BoxDecoration(
                              color: (activeSortColumn == column.value) ? headerConfig.color : Colors.transparent,
                              borderRadius: headerConfig.borderRadius,
                              border: headerConfig.border,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    column.text,
                                    textAlign: headerConfig.textAlign,
                                    style: (activeSortColumn == column.value) ? headerConfig.styleSelected : headerConfig.style,
                                  ),
                                ),
                                if (activeSortColumn == column.value)
                                  column.sortAscending ? headerConfig.iconDescending : headerConfig.iconAscending,
                              ],
                            ),
                          ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildSearch() {
    IdeTableHeader header = widget.header;
    IdeTableSearch search = widget.search!;

    return Container(
      padding: search.padding,
      //margin: search.margin,
      decoration: search.decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.checkboxShow && widget.dataSelecteds != null)
            const SizedBox(
              width: 30,
              height: 30,
            ),
          ...widget.dataColumns.where((header) => header.visible == true).map(
            (column) {
              IdeTableHeaderConfig headerConfig = header.config!;
              if (column.config != null) {
                headerConfig = column.config!;
              }

              if (column.constraint != null) {
                return IntrinsicWidth(
                  child: Container(
                    constraints: column.constraint,
                    child: Opacity(
                      opacity: column.search ? 1 : 0,
                      child: Container(
                        padding: headerConfig.padding,
                        //margin: headerConfig.margin,
                        margin: const EdgeInsets.only(left: 6, bottom: 3, top: 3),
                        decoration: BoxDecoration(
                          color: (activeSortColumn == column.value) ? headerConfig.color : Colors.black.withValues(alpha:0.03),
                          borderRadius: headerConfig.borderRadius,
                          border: headerConfig.border,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 20,
                                padding: const EdgeInsets.only(left: 3, right: 5, top: 5),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    isDense: true,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                  textAlign: TextAlign.left,
                                  cursorHeight: 19,
                                  style: TextStyle(fontSize: 14, color: Colors.black, height: 1.3),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  flex: column.flex,
                  child: Opacity(
                    opacity: column.search ? 1 : 0,
                    child: Container(
                      padding: headerConfig.padding,
                      //margin: headerConfig.margin,
                      margin: const EdgeInsets.only(left: 6, bottom: 3, top: 3),
                      decoration: BoxDecoration(
                        color: (activeSortColumn == column.value) ? headerConfig.color : Colors.black.withValues(alpha:0.03),
                        borderRadius: headerConfig.borderRadius,
                        border: headerConfig.border,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 20,
                              padding: const EdgeInsets.only(left: 3, right: 5, top: 5),
                              child: const TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  isDense: true,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                textAlign: TextAlign.left,
                                cursorHeight: 19,
                                style: TextStyle(fontSize: 14, color: Colors.black, height: 1.3),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildFooter() {
    IdeTableHeader header = widget.header;
    IdeTableFooter footer = widget.footer!;

    return Container(
      padding: footer.padding,
      margin: footer.margin,
      decoration: footer.decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.checkboxShow && widget.dataSelecteds != null)
            const SizedBox(
              width: 30,
              height: 30,
            ),
          ...widget.dataColumns.where((header) => header.visible == true).map(
            (column) {
              IdeTableHeaderConfig headerConfig = header.config!;
              if (column.config != null) {
                headerConfig = column.config!;
              }

              //TODO:: Implementar skin do footer
              if (column.constraint != null) {
                return IntrinsicWidth(
                  child: Container(
                    constraints: column.constraint,
                    child: Opacity(
                      opacity: column.search ? 1 : 0,
                      child: Container(
                          //padding: headerConfig.padding,
                          decoration: BoxDecoration(
                            borderRadius: headerConfig.borderRadius,
                            border: headerConfig.border,
                          ),
                          child: column.footerBuilder != null ? column.footerBuilder!(column.value) : const SizedBox.shrink()),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  flex: column.flex,
                  child: Opacity(
                    opacity: column.search ? 1 : 0,
                    child: Container(
                        padding: headerConfig.padding,
                        margin: const EdgeInsets.only(left: 6, bottom: 3, top: 3),
                        decoration: BoxDecoration(
                          borderRadius: headerConfig.borderRadius,
                          border: headerConfig.border,
                        ),
                        child: column.footerBuilder != null ? column.footerBuilder!(column.value) : const SizedBox.shrink()),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  List<Widget> buildList() {
    List<Widget> widgets = [];
    for (var index = 0; index < widget.dataSource.length; index++) {
      listSelected[index] = false;
      final data = widget.dataSource[index];
      widgets.add(
        Column(
          children: [
            IdeTableRowRender(
              dataColumns: [...widget.dataColumns],
              cellStyle: widget.style?.cell,
              rowStyle: widget.style?.row,
              rowHoverStyle: widget.style?.rowHover,
              rowSelectedStyle: widget.style?.rowSelected,
              rowCheckedStyle: widget.style?.rowChecked,
              rowExpandedStyle: widget.expandedPanel?.rowStyle,
              checkboxShow: widget.checkboxShow,
              isExpanded: widget.expandedPanel != null && widget.expandedPanel!.visible ? widget.expandedPanel!.expandedList[index] : false,
              hasExpanded: widget.expandedPanel != null && widget.expandedPanel!.visible,
              data: data,
              onChanged: (value) {
                if (widget.onCheckboxSelected != null) {
                  widget.onCheckboxSelected!(value, data);
                }
              },
              isSelected: (selectedItem != null && checkSelectedItem(data)),
              isChecked: widget.dataSelecteds!.contains(data),
              onRowClickSelected: () {
                onRowClickSelected(data, index);
              },
              onRowDoubleClickSelected: () {
                onRowDoubleClickSelected(data, index);
              },
              header: widget.header,
              dataSelecteds: widget.dataSelecteds,
              onChangedRow: widget.onChangedRow,
              onSubmittedRow: widget.onSubmittedRow,
            ),
          ],
        ),
      );
    }
    return widgets;
  }

  bool checkSelectedItem(data) {
    if ((data["id"] != null && selectedItem["id"] != null) && (data["id"] == selectedItem["id"])) {
      return true;
    }
    if ((data["_id"] != null && selectedItem["_id"] != null) && (data["_id"] == selectedItem["_id"])) {
      return true;
    }
    return false;
  }

  List<Widget> buildListExpands() {
    final IdeTableExpandedPanelStyle themeExpandedPanelStyle = Theme.of(context).extension<IdeTableExpandedPanelStyle>()!;
    final EdgeInsetsGeometry? expandedPanelStyleMargin = widget.expandedPanel?.style?.margin ?? themeExpandedPanelStyle.margin;
    final BoxDecoration? expandedPanelStyleDecoration = widget.expandedPanel?.style?.decoration ?? themeExpandedPanelStyle.decoration;

    List<Widget> widgets = [];
    for (var index = 0; index < widget.dataSource.length; index++) {
      listSelected[index] = false;
      final data = widget.dataSource[index];
      if (widget.expandedPanel != null && widget.expandedPanel!.visible && widget.expandedPanel!.showRowWhenExpanded) {
        widgets.add(
          Column(
            children: [
              IdeTableRowRender(
                dataColumns: [...widget.dataColumns],
                cellStyle: widget.style?.cell,
                rowStyle: widget.style?.row,
                rowHoverStyle: widget.style?.rowHover,
                rowSelectedStyle: widget.style?.rowSelected,
                rowCheckedStyle: widget.style?.rowChecked,
                rowExpandedStyle: widget.expandedPanel?.rowStyle,
                checkboxShow: widget.checkboxShow,
                isExpanded: widget.expandedPanel != null && widget.expandedPanel!.visible && widget.expandedPanel!.expandedList[index],
                hasExpanded: widget.expandedPanel != null && widget.expandedPanel!.visible,
                data: data,
                onChanged: (value) {
                  if (widget.onCheckboxSelected != null) {
                    widget.onCheckboxSelected!(value, data);
                  }
                },
                isSelected: (selectedItem != null && checkSelectedItem(data)),
                isChecked: widget.dataSelecteds!.contains(data),
                onRowClickSelected: () {
                  onRowClickSelected(data, index);
                },
                onRowDoubleClickSelected: () {
                  onRowDoubleClickSelected(data, index);
                },
                header: widget.header,
                dataSelecteds: widget.dataSelecteds,
                onChangedRow: widget.onChangedRow,
                onSubmittedRow: widget.onSubmittedRow,
              ),
              if (widget.expandedPanel != null && widget.expandedPanel!.visible && widget.expandedPanel!.expandedList[index])
                Container(
                  decoration: expandedPanelStyleDecoration,
                  margin: expandedPanelStyleMargin,
                  child: ClipRRect(
                    borderRadius: expandedPanelStyleDecoration != null && expandedPanelStyleDecoration.borderRadius != null
                        ? expandedPanelStyleDecoration.borderRadius!
                        : BorderRadius.zero,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.checkboxShow && widget.dataSelecteds != null && widget.expandedPanel!.checkboxShow)
                          Checkbox(
                            splashRadius: 0,
                            value: widget.dataSelecteds!.contains(data),
                            onChanged: (value) {
                              if (widget.onCheckboxSelected != null) {
                                widget.onCheckboxSelected!(value, data);
                              }
                            },
                          ),
                        Expanded(
                          child: Container(
                            child: (widget.expandedPanel!.showButtonClose)
                                ? widget.expandedPanel!.onExpanded(data)
                                : InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                                    onTap: () {
                                      onRowClickSelected(data, index);
                                    },
                                    child: widget.expandedPanel!.onExpanded(data),
                                  ),
                          ),
                        ),
                        if (widget.expandedPanel!.showButtonClose)
                          IconButton(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            icon: widget.expandedPanel!.icon,
                            onPressed: () {
                              onRowClickSelected(data, index);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      } else {
        widgets.add(
          Column(
            children: [
              if (widget.expandedPanel != null && widget.expandedPanel!.visible && !widget.expandedPanel!.expandedList[index])
                IdeTableRowRender(
                  dataColumns: [...widget.dataColumns],
                  cellStyle: widget.style?.cell,
                  rowStyle: widget.style?.row,
                  rowHoverStyle: widget.style?.rowHover,
                  rowSelectedStyle: widget.style?.rowSelected,
                  rowCheckedStyle: widget.style?.rowChecked,
                  rowExpandedStyle: widget.expandedPanel?.rowStyle,
                  checkboxShow: widget.checkboxShow,
                  isExpanded: widget.expandedPanel != null && widget.expandedPanel!.visible && widget.expandedPanel!.expandedList[index],
                  hasExpanded: widget.expandedPanel != null && widget.expandedPanel!.visible,
                  data: data,
                  onChanged: (value) {
                    if (widget.onCheckboxSelected != null) {
                      widget.onCheckboxSelected!(value, data);
                    }
                  },
                  isSelected: (selectedItem != null && checkSelectedItem(data)),
                  isChecked: widget.dataSelecteds!.contains(data),
                  onRowClickSelected: () {
                    onRowClickSelected(data, index);
                  },
                  onRowDoubleClickSelected: () {
                    onRowDoubleClickSelected(data, index);
                  },
                  header: widget.header,
                  dataSelecteds: widget.dataSelecteds,
                  onChangedRow: widget.onChangedRow,
                  onSubmittedRow: widget.onSubmittedRow,
                ),
              if (widget.expandedPanel != null && widget.expandedPanel!.visible && widget.expandedPanel!.expandedList[index])
                Container(
                  decoration: expandedPanelStyleDecoration,
                  margin: expandedPanelStyleMargin,
                  child: ClipRRect(
                    borderRadius: expandedPanelStyleDecoration != null && expandedPanelStyleDecoration.borderRadius != null
                        ? expandedPanelStyleDecoration.borderRadius!
                        : BorderRadius.zero,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.checkboxShow && widget.dataSelecteds != null && widget.expandedPanel!.checkboxShow)
                          Checkbox(
                            splashRadius: 0,
                            value: widget.dataSelecteds!.contains(data),
                            onChanged: (value) {
                              if (widget.onCheckboxSelected != null) {
                                widget.onCheckboxSelected!(value, data);
                              }
                            },
                          ),
                        Expanded(
                          child: Container(
                            child: (widget.expandedPanel!.showButtonClose)
                                ? widget.expandedPanel!.onExpanded(data)
                                : InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                                    onTap: () {
                                      onRowClickSelected(data, index);
                                    },
                                    child: widget.expandedPanel!.onExpanded(data),
                                  ),
                          ),
                        ),
                        if (widget.expandedPanel!.showButtonClose)
                          IconButton(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            icon: widget.expandedPanel!.icon,
                            onPressed: () {
                              onRowClickSelected(data, index);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (widget.header.visible) {
      children.add(buildHeader());
    }
    if (widget.search != null && widget.search!.visible) {
      children.add(buildSearch());
    }

    if (widget.autoHeight) {
      if (widget.expandedPanel != null && widget.expandedPanel!.visible) {
        children.add(Column(children: buildListExpands()));
      } else {
        children.add(Column(children: buildList()));
      }
    } else if (!widget.autoHeight) {
      if (widget.expandedPanel != null && widget.expandedPanel!.visible) {
        children.add(Expanded(child: SuperListView(children: buildListExpands())));
      } else {
        children.add(Expanded(child: SuperListView(children: buildList())));
      }
    }
    if (widget.footer != null && widget.footer!.visible) {
      children.add(buildFooter());
    }

    if (widget.paginator != null && widget.paginator!.visible) {
      IdeTablePaginatorCore paginator = IdeTablePaginatorCore(
        onPagination: () {
          widget.paginator!.onPaginator();
        },
        pageInfo: widget.paginator!.controller.pageInfo,
      );
      children.add(paginator);
    }

    Column column = Column(children: children);
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha:0.03),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (widget.dataSource.isEmpty) {
            return SizedBox(
              height: widget.maxHeight,
              child: Stack(
                children: [
                  SizedBox(height: widget.maxHeight, child: column),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline_rounded, color: theme.colorScheme.primaryContainer, size: 40),
                        Text('Nenhum dado disponível.', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (widget.minWidth != null && constraints.maxWidth < widget.minWidth!) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: widget.maxHeight,
                width: widget.minWidth!,
                child: column,
              ),
            );
          }
          return SizedBox(height: widget.maxHeight, child: column);
        },
      ),
    );
  }
}
