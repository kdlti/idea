import 'package:idea/package.dart';
import 'package:idea/src/custom/filter/config/ide_custom_filter_config_field.dart';

class IdeCustomFilterConfig {
  final List<IdeCustomFilterConfigField> fields = [];

  void addFilter({
    required String field,
    required String label,
    int? initialIndexCondition,
    int? initialIndexOption,
    required List<IdeCustomFilterConfigCondition> listCondition,
    List<IdeCustomFilterConfigOption>? listOptions,
    required IdeCustomFilterType type,
  }) {
    if (fields.any((element) => element.field == field)) {
      throw Exception('Field $field already exists');
    }
    if (listCondition.isEmpty) {
      throw Exception('Condition is required');
    }
    if (type == IdeCustomFilterType.select && listOptions == null) {
      throw Exception('Option is required');
    }
    if (type == IdeCustomFilterType.selectMultiple && listOptions == null) {
      throw Exception('Option is required');
    }
    fields.add(IdeCustomFilterConfigField(field, label, initialIndexCondition, initialIndexOption, listCondition, listOptions, type));
  }
}
