import 'package:flutter/material.dart';
import 'package:idea/package.dart';

abstract class IdeModules {
  List<IdeModule> build(BuildContext context) {
    throw UnimplementedError();
  }
}
