import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';

class IdeMaterial {
  final BuildContext context;
  final List<IdeModules> modules;

  List<GetPage> get pages {
    List<GetPage> listPages = [];

    for (IdeModules ideModule in modules) {
      for (var workspace in ideModule.build(context)) {
        listPages.add(workspace.page);
      }
    }

    return listPages;
  }

  IdeMaterial(
    this.context, {
    required this.modules,
  });
}
