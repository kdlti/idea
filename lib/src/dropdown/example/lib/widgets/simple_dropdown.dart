import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:idea/src/dropdown/ide_dropdown.dart';

const List<String> _list = [
  'Developer',
  'Designer',
  'Consultant',
  'Student',
];

class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdeDropdown<String>(
      hintText: 'Select job role',
      items: _list,
      initialItem: _list[0],
      excludeSelected: false,
      onChanged: (value) {
        log('SimpleDropdown onChanged value: $value');
      },
    );
  }
}
