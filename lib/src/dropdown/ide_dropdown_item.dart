import 'package:idea/package.dart';

class IdeDropdownItem<T> with IdeDropdownListFilter {
  final String label;
  T value;

  IdeDropdownItem({required this.label, required this.value});

  @override
  String toString() {
    return label;
  }

  @override
  bool filter(String query) {
    return label.toLowerCase().contains(query.toLowerCase());
  }
}