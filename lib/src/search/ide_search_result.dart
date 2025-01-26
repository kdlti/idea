import 'package:idea/src/search/popup/ide_search_popup_item.dart';

enum IdeSearchEventType {
  search,
  selectColumns,
  reset,
}

class IdeSearchResult {
  final String search;
  final List<IdeSearchPopupItem> columns;
  final bool isSearch;
  final IdeSearchEventType event;

  IdeSearchResult({
    required this.search,
    required this.columns,
    required this.event,
    this.isSearch = false,
  });

  Map<String, String> get fields {
    Map<String, String> result = {};

    for (var column in columns) {
      if (column.selected) {
        result[column.name] = "INCLUDE";
      }
    }

    return result;
  }

  Map<String, dynamic> get params {
    return {
      "text": search,
      "fields": fields,
      "regex": null,
    };
  }

  @override
  toString() {
    return 'IdeSearchResult(search: $search, columns: $columns, isSearch: $isSearch, event: $event)';
  }
}
