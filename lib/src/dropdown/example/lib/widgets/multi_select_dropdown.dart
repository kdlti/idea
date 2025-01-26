import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:idea/src/dropdown/example/lib/models/job.dart';
import 'package:idea/src/dropdown/ide_dropdown.dart';

class MultiSelectDropdown extends StatelessWidget {
  const MultiSelectDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdeDropdown<Job>.multiSelect(
      items: jobItems,
      initialItems: jobItems.take(2).toList(),
      onListChanged: (value) {
        log('MultiSelectDropdown onChanged value: $value');
      },
    );
  }
}
