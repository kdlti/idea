import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:idea/src/dropdown/example/lib/models/job.dart';
import 'package:idea/src/dropdown/ide_dropdown.dart';

class ValidationDropdown extends StatelessWidget {
  ValidationDropdown({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IdeDropdown<Job>(
            hintText: 'Select job role',
            items: jobItems,
            excludeSelected: false,
            onChanged: (value) {
              log('ValidationDropdown onChanged value: $value');
            },
            validator: (value) {
              if (value == null) {
                return "Must not be null";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiSelectValidationDropdown extends StatelessWidget {
  MultiSelectValidationDropdown({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IdeDropdown<Job>.multiSelect(
            hintText: 'Select job role',
            items: jobItems,
            onListChanged: (value) {
              log('MultiSelectValidationDropdown onChanged value: $value');
            },
            listValidator: (value) {
              if (value.isEmpty) {
                return "Must not be null";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
