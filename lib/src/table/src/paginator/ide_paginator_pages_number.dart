import 'package:flutter/material.dart';
import 'package:idea/src/table/src/paginator/ide_table_pagination.dart';

typedef IdePaginatorPagesNumberCallBack<S> = S Function(S);

class IdePaginatorPagesNumber extends StatelessWidget {
  final IdeTablePagination pagination;
  final IdePaginatorPagesNumberCallBack onGotoPage;

  const IdePaginatorPagesNumber(this.pagination, {super.key, required this.onGotoPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildNumberButtons(),
    );
  }

  List<Opacity> buildNumberButtons() {
    List<Opacity> numberButtons = [];
    if (pagination.pages.length > 1) {
      for (var index in pagination.pages) {
        numberButtons.add(
          Opacity(
            opacity: (pagination.pageInfo.page != index) ? 1 : 0.3,
            child: IgnorePointer(
              ignoring: (pagination.pageInfo.page == index),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(maxHeight: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  margin: const EdgeInsets.only(right: 5),
                  alignment: Alignment.center,
                  child: Text(index.toString()),
                ),
                onTap: () {
                  onGotoPage(index);
                },
              ),
            ),
          ),
        );
      }
    }
    return numberButtons;
  }
}
