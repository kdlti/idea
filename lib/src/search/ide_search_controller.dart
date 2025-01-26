import 'package:idea/package.dart';
import 'package:idea/src/search/ide_search_result.dart';
import 'package:idea/src/search/popup/ide_search_popup_item.dart';

class IdeSearchController {
  String value = '';
  List<String> fields = [];
  bool isSearch = false;
  final List<IdeSearchPopupItem> searchColumns;

  IdeSearchController({
    required this.searchColumns,
  });

  void addSearchResult(IdeSearchResult searchResult) {
    isSearch = searchResult.isSearch;
    fields.clear();
    value = '';
    if (isSearch) {
      value = searchResult.search;
      for (var column in searchResult.columns) {
        if (column.selected) {
          if (!fields.contains(column.name)) {
            fields.add(column.name);
          }
        }
      }
    }
  }

  void addFilterResult(IdeCustomFilterResult value) {}

  @override
  String toString() {
    return 'IdeSearchController{text: $value, fields: $fields, isSearch: $isSearch, searchColumns: $searchColumns}';
  }

  void clear() {
    value = '';
    fields.clear();
    isSearch = false;
  }
}
