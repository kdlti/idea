class IdeTableSort {
  String field = '';
  bool sortAscending = true;

  bool get isSort => field.isNotEmpty;

  String get direction => sortAscending ? 'desc' : 'asc';

  @override
  String toString() {
    return 'IdeTableSort{field: $field, sortAscending: $sortAscending, isSort: $isSort, direction: $direction}';
  }
}
