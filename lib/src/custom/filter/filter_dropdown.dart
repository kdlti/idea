import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:idea/src/dropdown/ide_dropdown.dart';

const List<String> _list = [
  'Developer',
  'Designer',
  'Consultant',
  'Student',
];
class Job with IdeDropdownListFilter {
  final String name;
  final IconData icon;
  const Job(this.name, this.icon);

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}


class FilterDropdown extends StatelessWidget {
  const FilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Job> list = [
      Job('Status', Icons.developer_mode),
      Job('Designer', Icons.design_services),
      Job('Consultant', Icons.account_balance),
    ];

    return IdeDropdown<Job>(
      hintText: 'Select job role',
      items: list,
      onChanged: (value) {
        log('changing value to: $value');
      },
      listItemPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      expandedHeaderPadding: const EdgeInsets.all(15),
      closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      canCloseOutsideBounds: true,
      decoration:  IdeDropdownDecoration(
        errorStyle: const TextStyle(color: Colors.transparent),
        headerStyle: const TextStyle(color: Colors.blue,fontSize: 14),
        hintStyle: const TextStyle(color: Colors.grey,fontSize: 14),
        listItemStyle: const TextStyle(color: Colors.black,fontSize: 14),
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
          textStyle: const TextStyle(color: Colors.grey,fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 16),
          suffixIcon: (VoidCallback onClear) => InkWell(
            onTap: onClear,
            child: const Icon(Icons.clear, color: Colors.grey, size: 16),
          ),
        ),
      ),
    );

    /*return CustomDropdown<Job>.multiSelectSearch(
      hintText: 'Select job role',
      items: _list,
      onListChanged: (value) {
        log('changing value to: $value');
      },
      listValidator: (value) => value.isEmpty ? "Must not be null" : null,
      listItemPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      expandedHeaderPadding: const EdgeInsets.all(15),
      closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      searchHintText: 'Search X',
      canCloseOutsideBounds: true,
      decoration:  CustomDropdownDecoration(
        errorStyle: const TextStyle(color: Colors.transparent),
        headerStyle: const TextStyle(color: Colors.black,fontSize: 14),
        hintStyle: const TextStyle(color: Colors.black,fontSize: 14),
        listItemStyle: const TextStyle(color: Colors.black,fontSize: 14),
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
          textStyle: const TextStyle(color: Colors.grey,fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 16),
          suffixIcon: (VoidCallback onClear) => InkWell(
            onTap: onClear,
            child: const Icon(Icons.clear, color: Colors.grey, size: 16),
          ),
        ),
      ),
    );*/
  }
}