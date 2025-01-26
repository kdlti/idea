
import 'package:idea/src/table/src/paginator/ide_table_page_info.dart';

class IdeTablePagination {
  int _itemsPerPage = 100;
  List<dynamic> pages = [];
  final IdeTablePageInfo pageInfo;

  IdeTablePagination({required this.pageInfo}) {
    _itemsPerPage = pageInfo.limit;
    _createPages();
  }

  String get itemsPerPage => _itemsPerPage.toString();

  set itemsPerPage(String value) {
    _itemsPerPage = int.parse(value);
    pageInfo.limit = _itemsPerPage;
    _createPages(); // Recreate pages because the number of items per page changed
  }

  get total => pageInfo.total;

  int get index {
    if (pageInfo.total < 1 || pageInfo.page < 1) {
      return 0;
    } else if (pageInfo.page < 2) {
      return 1;
    }
    return (pageInfo.page - 1) * _itemsPerPage;
  }

  int get indexTotal {
    if (pageInfo.total < 1 || pageInfo.page < 1) {
      return 0;
    } else if (pageInfo.total > (pageInfo.page * _itemsPerPage)) {
      return pageInfo.page * _itemsPerPage;
    }
    return pageInfo.total;
  }

  int get lastPageNumber => _lastPage();
  int get pageNumber => pageInfo.page < 1 ? 1 : pageInfo.page;

  int _lastPage() {
    var n = (pageInfo.total / _itemsPerPage).ceil(); // Use ceil to ensure rounding up
    return n;
  }

  void lastPage() {
    pageInfo.page = _lastPage();
  }

  void firstPage() {
    pageInfo.page = 1;
  }

  void goToPage(int value) {
    if (value > 0 && value <= _lastPage()) {
      pageInfo.page = value;
    } else {
      pageInfo.page = _lastPage();
    }
  }

  void back() {
    if (pageInfo.page > 1) {
      pageInfo.page--;
    }
  }

  void next() {
    if (pageInfo.page < _lastPage()) {
      pageInfo.page++;
    }
  }

  @override
  String toString() {
    return 'Instance of IdeTablePagination(itemsPerPage:$_itemsPerPage, hasPreviousPage:${pageInfo.hasPrevious}, '
        'hasNext:${pageInfo.hasNext}, index:$index, lastPageNumber:$lastPageNumber, pageNumber:$pageNumber)';
  }

  void reset() {
    pageInfo.page = 1;
    _createPages();
  }

  void _createPages() {
    pages = [];
    int totalPages = _lastPage();
    for (int i = 0; i < totalPages; i++) {
      pages.add(i + 1);
    }
  }
}