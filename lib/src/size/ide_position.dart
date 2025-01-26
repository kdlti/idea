import 'package:flutter/material.dart';

class IdePosition {
  double top;
  double bottom;
  double left;
  double right;

  IdePosition({
    this.top = 0,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
  });

  IdePosition copyWith({double? left, double? right, double? top, double? bottom}) {
    return IdePosition(
      left: left ?? this.left,
      right: right ?? this.right,
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
    );
  }

  //================================================================================
  //
  // global
  //
  //================================================================================
  static RelativeRect global(BuildContext context, Offset offset) {
    final RenderBox widget = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        widget.localToGlobal(offset, ancestor: overlay),
        widget.localToGlobal(widget.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }

  void reset(){
    top = 0;
    bottom = 0;
    left = 0;
    right = 0;
  }

  @override
  String toString() {
    return 'Instance of IdePosition:(top:$top, bottom:$bottom, left:$left, right:$right)';
  }
}
