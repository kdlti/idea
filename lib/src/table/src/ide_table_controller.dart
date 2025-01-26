import 'package:idea/src/table/src/ide_table_sort.dart';
import 'package:idea/src/table/src/paginator/ide_table_page_info.dart';

class IdeTableController {
  final IdeTableSort sort = IdeTableSort();
  IdeTablePageInfo pageInfo = IdeTablePageInfo();

  set pagination(dynamic json) {
    pageInfo = IdeTablePageInfo.fromJson(json);
  }

  Map<String, dynamic> get params => pageInfo.params;
  Map<String, dynamic> get pagination => pageInfo.pagination;

  @override
  String toString() {
    return 'IdeTableController{pageInfo: $pageInfo, sort: $sort}';
  }
}
