import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IdeMeasuredSizeWidget extends SingleChildRenderObjectWidget {
  const IdeMeasuredSizeWidget({super.key, required this.onChange, required Widget super.child});
  final void Function(Size size) onChange;
  @override
  RenderObject createRenderObject(BuildContext context) => _IdeMeasureSizeRenderObject(onChange);
}

class _IdeMeasureSizeRenderObject extends RenderProxyBox {
  _IdeMeasureSizeRenderObject(this.onChange);
  void Function(Size size) onChange;

  Size? _prevSize;
  @override
  void performLayout() {
    super.performLayout();
    Size newSize = child?.size ?? Size.zero;
    if (_prevSize == newSize) return;
    _prevSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) => onChange(newSize));
  }
}
