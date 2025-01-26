class IdeCustomFilterValue {
  int index;
  String logic;
  String op;
  String field;
  List<String> values;
  List<IdeCustomFilterValue?> subFilters;

  IdeCustomFilterValue({
    required this.index,
    required this.logic,
    required this.op,
    required this.field,
    required this.values,
    required this.subFilters,
  });

  factory IdeCustomFilterValue.fromJson(Map<String, dynamic> json) {
    return IdeCustomFilterValue(
      index: json['index'] ?? 0,
      logic: json['logic'] ?? 'AND',
      op: json['op'] ?? 'EQ',
      field: json['field'] ?? '',
      values: json['values'] ?? [],
      subFilters: json['subFilters'] != null ? (json['subFilters'] as List).map((e) => IdeCustomFilterValue.fromJson(e)).toList() : []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'logic': logic,
      'op': op,
      'field': field,
      'values': values,
      'subFilters': subFilters,
    };
  }

  @override
  String toString() {
    return 'IdeCustomFilterValue{index: $index, logic: $logic, op: $op, field: $field, values: $values, subFilters: $subFilters}';
  }
}
