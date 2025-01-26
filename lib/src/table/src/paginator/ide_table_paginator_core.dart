import 'package:flutter/material.dart';
import 'package:idea/src/table/src/paginator/ide_paginator_pages_number.dart';
import 'package:idea/src/table/src/paginator/ide_table_page_info.dart';
import 'package:idea/src/table/src/paginator/ide_table_pagination.dart';

class IdeTablePaginatorCore extends StatefulWidget {
  final VoidCallback onPagination;
  final IdeTablePageInfo pageInfo;

  const IdeTablePaginatorCore({
    super.key,
    required this.onPagination,
    required this.pageInfo,
  });

  @override
  IdeTablePaginatorCoreState createState() => IdeTablePaginatorCoreState();
}

class IdeTablePaginatorCoreState extends State<IdeTablePaginatorCore> {
  TextEditingController pageNumberController = TextEditingController();
  late IdeTablePagination pagination;

  @override
  void initState() {
    super.initState();
    pagination = IdeTablePagination(pageInfo: widget.pageInfo);
    // Atualize para refletir a página atual corretamente
    pageNumberController.text = pagination.pageNumber.toString();
  }

  @override
  void dispose() {
    pageNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 50,
          child: Opacity(
            opacity: (pagination.total > 0) ? 1 : 0.3,
            child: IgnorePointer(
              ignoring: (pagination.total <= 0),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 20),
                  IdePaginatorPagesNumber(pagination, onGotoPage: (dynamic value) {
                    pagination.goToPage(value as int);
                    pageNumberController.text = pagination.pageNumber.toString(); // Assegure-se de refletir a mudança
                    widget.onPagination();
                  }),
                  const Spacer(flex: 1),
                  if(constraints.maxWidth > 500)
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text('Itens por página'),
                  ),
                  DropdownButton<String>(
                    value: pagination.itemsPerPage,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black87),
                    underline: Container(
                      height: 1,
                      color: Colors.black87,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        pagination.itemsPerPage = newValue!;
                        pagination.reset(); // Redefine para a primeira página após mudança de itens por página
                        pageNumberController.text = pagination.pageNumber.toString();
                        widget.onPagination();
                      });
                    },
                    items: <String>['5', '10', '25', '50', '100', '250', '500', '1000'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 20),
                  Text('${pagination.index.toString()} - ${pagination.indexTotal.toString()} de ${pagination.total.toString()}'),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.first_page, color: pagination.pageInfo.hasPrevious ? Colors.blueAccent : Colors.black12),
                    onPressed: pagination.pageInfo.hasPrevious
                        ? () {
                      setState(() {
                        pagination.firstPage();
                        pageNumberController.text = pagination.pageNumber.toString();
                        widget.onPagination();
                      });
                    }
                        : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, color: pagination.pageInfo.hasPrevious ? Colors.blueAccent : Colors.black12),
                    onPressed: pagination.pageInfo.hasPrevious
                        ? () {
                      setState(() {
                        pagination.back();
                        pageNumberController.text = pagination.pageNumber.toString();
                        widget.onPagination();
                      });
                    }
                        : null,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: pageNumberController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      textAlign: TextAlign.center,
                      onSubmitted: (String value) {
                        final int page = int.tryParse(value) ?? 1;
                        setState(() {
                          pagination.goToPage(page);
                          pageNumberController.text = pagination.pageNumber.toString();
                          widget.onPagination();
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_right, color: pagination.pageInfo.hasNext ? Colors.blueAccent : Colors.black12),
                    onPressed: pagination.pageInfo.hasNext
                        ? () {
                      setState(() {
                        pagination.next();
                        pageNumberController.text = pagination.pageNumber.toString();
                        widget.onPagination();
                      });
                    }
                        : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.last_page, color: pagination.pageInfo.hasNext ? Colors.blueAccent : Colors.black12),
                    onPressed: pagination.pageInfo.hasNext
                        ? () {
                      setState(() {
                        pagination.lastPage();
                        pageNumberController.text = pagination.pageNumber.toString();
                        widget.onPagination();
                      });
                    }
                        : null,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
