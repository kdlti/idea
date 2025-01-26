import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/custom/filter/ide_custom_filter_selected.dart';

class FilterDropdownFields extends StatelessWidget {
  final IdeCustomFilterConfig config;
  final VoidCallback onChanged;
  final IdeCustomFilterActive filterActive;

  const FilterDropdownFields({
    super.key,
    required this.config,
    required this.onChanged,
    required this.filterActive,
  });

  @override
  Widget build(BuildContext context) {
    return IdeDropdown<IdeDropdownItem>(
      hintText: 'Selecionar filtro',
      items: config.fields.map((field) => IdeDropdownItem(label:field.label, value:"")).toList(),
      onChanged: (dropdown) {
        filterActive.field = config.fields.firstWhere((element) => element.label == dropdown.value);
        filterActive.condition = null;
        filterActive.initialIndexCondition = null;
        if (filterActive.field!.initialIndexCondition != null) {
          filterActive.condition = filterActive.field!.listCondition[filterActive.field!.initialIndexCondition!];
          filterActive.initialIndexCondition = filterActive.field!.initialIndexCondition;
        }

        onChanged();
      },
      listItemPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      expandedHeaderPadding: const EdgeInsets.all(10),
      closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      canCloseOutsideBounds: true,
      decoration: IdeDropdownDecoration(
        errorStyle: const TextStyle(color: Colors.transparent),
        headerStyle: const TextStyle(color: Colors.black, fontSize: 14),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        listItemStyle: const TextStyle(color: Colors.black, fontSize: 14),
        closedErrorBorderRadius: const BorderRadius.all(Radius.circular(4)),
        closedBorderRadius: const BorderRadius.all(Radius.circular(4)),
        expandedBorderRadius: const BorderRadius.all(Radius.circular(4)),
        closedBorder: const Border(
          top: BorderSide(color: Colors.black12),
          bottom: BorderSide(color: Colors.black12),
          left: BorderSide(color: Colors.black12),
          right: BorderSide(color: Colors.black12),
        ),
        searchFieldDecoration: SearchFieldDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          constraints: const BoxConstraints.tightFor(height: 30),
          contentPadding: const EdgeInsets.all(2),
          textStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 16),
          suffixIcon: (VoidCallback onClear) => InkWell(
            onTap: onClear,
            child: const Icon(Icons.clear, color: Colors.grey, size: 16),
          ),
        ),
      ),
    );
  }
}
