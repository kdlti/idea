import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/custom/filter/ide_custom_filter_selected.dart';

class FilterDropdownCondition extends StatelessWidget {
  final IdeCustomFilterActive filterActive;
  final VoidCallback onChanged;

  const FilterDropdownCondition({
    super.key,
    required this.filterActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final listItems = filterActive.field!.listCondition.map((condition) => IdeDropdownItem(label: condition.label, value: "")).toList();

    return IdeDropdown<IdeDropdownItem>(
      hintText: 'Selecionar condição',
      items: listItems,
      onChanged: (dropdown) {
        filterActive.condition = filterActive.field!.listCondition.firstWhere((element) => element.label == dropdown.label);
        filterActive.initialIndexCondition = listItems.indexWhere((element) => element.label == dropdown.label);

        onChanged();
      },
      listItemPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      expandedHeaderPadding: const EdgeInsets.all(10),
      closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      canCloseOutsideBounds: true,
      initialItem: filterActive.initialIndexCondition != null ? listItems[filterActive.initialIndexCondition!] : null,
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
