import 'package:flutter/material.dart';
import 'package:idea/package.dart';

const List<Job> jobItems = [
  Job('Developer', Icons.developer_mode),
  Job('Designer', Icons.design_services),
  Job('Consultant', Icons.account_balance),
  Job('Student', Icons.school),
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
