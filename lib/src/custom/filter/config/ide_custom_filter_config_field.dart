import 'package:idea/package.dart';

class IdeCustomFilterConfigField {
  final String field;
  final String label;
  final int? initialIndexCondition;
  final int? initialIndexOption;
  final List<IdeCustomFilterConfigCondition> listCondition;
  final IdeCustomFilterType type;
  final List<IdeCustomFilterConfigOption>? listOptions;

  IdeCustomFilterConfigField(
    this.field,
    this.label,
    this.initialIndexCondition,
    this.initialIndexOption,
    this.listCondition,
    this.listOptions,
    this.type,
  );

  @override
  String toString() {
    return 'Instance of IdeCustomFilterConfigField(field: $field, label: $label, initialIndexCondition: $initialIndexCondition, '
        'initialIndexOption: $initialIndexOption, condition: $listCondition, type: $type, listOptions: $listOptions)';
  }
}
