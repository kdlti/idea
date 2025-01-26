import 'package:flutter/material.dart';

class StackedOptions {
  /// The key of the stacked notification, if you want to stack the notifications
  final String key;

  /// The offset of the stacked item from the previous stacked item
  final Offset itemOffset;

  /// The scale factor of the stacked item from the previous stacked item
  final double scaleFactor;

  /// The type of the stack
  final StackedType type;

  const StackedOptions({
    this.key = "top",
    this.itemOffset = const Offset(-5, -5),
    this.scaleFactor = 0,
    this.type = StackedType.same,
  });
}

enum StackedType {
  /// The new stacked item will be displayed above the previous stacked item
  above,

  /// The new stacked item will be displayed below the previous stacked item
  below,

  /// The new stacked item will be displayed with the same position as the previous stacked item
  same
}
