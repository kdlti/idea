import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:idea/src/dropdown/ide_dropdown.dart';

const _list = [
  'Pakistani',
  'Indian',
  'Middle Eastern',
  'Western',
  'Chinese',
  'Italian',
];

class SearchDropdown extends StatelessWidget {
  const SearchDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdeDropdown<String>.search(
      hintText: 'Select cuisines',
      items: _list,
      overlayHeight: 342,
      onChanged: (value) {
        log('SearchDropdown onChanged value: $value');
      },
    );
  }
}

class MultiSelectSearchDropdown extends StatelessWidget {
  const MultiSelectSearchDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdeDropdown<String>.multiSelectSearch(
      hintText: 'Select cuisines',
      items: _list,
      onListChanged: (value) {
        log('MultiSelectSearchDropdown onChanged value: $value');
      },
    );
  }
}
