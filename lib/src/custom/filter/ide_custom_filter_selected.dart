import 'package:idea/package.dart';
import 'package:idea/src/custom/filter/config/ide_custom_filter_config_field.dart';

class IdeCustomFilterActive {
  IdeCustomFilterConfigField? field;
  IdeCustomFilterConfigCondition? condition;
  IdeCustomFilterType? type;
  IdeCustomFilterConfigOption? option;
  int? initialIndexCondition;

  @override
  String toString() {
    return 'Instance of IdeCustomFilterActive(field: $field, condition: $condition, '
        'type: $type, option: $option, initialIndexCondition: $initialIndexCondition)';
  }
}
