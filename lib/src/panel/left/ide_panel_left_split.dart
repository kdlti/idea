import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/src/visibility/ide_visibility_builder.dart';

class IdePanelLeftSplit extends StatefulWidget {
  final Widget? top;
  final Widget? botton;
  final double? height;

  const IdePanelLeftSplit({
    this.top,
    this.botton,
    this.height,
    super.key,
  });

  @override
  _IdePanelLeftSplitState createState() => _IdePanelLeftSplitState();
}

class _IdePanelLeftSplitState extends State<IdePanelLeftSplit> {
  final RxDouble _resizeHeight = 0.0.obs;

  set resizeHeight(double value) => _resizeHeight.value = value;

  double get resizeHeight {
    return _resizeHeight.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.height == null && resizeHeight == 0.0) {
    } else if (widget.height != null && resizeHeight == 0.0) {
      resizeHeight = widget.height!;
    }

    return Stack(
      children: [
        IdeVisibilityBuilder(
          condition: widget.top != null,
          child: () => Positioned(top: 0, left: 0, right: 0, height: resizeHeight, child: widget.top!),
        ),
        IdeVisibilityBuilder(
          condition: widget.botton != null,
          child: () => Positioned(top: resizeHeight, bottom: 0, left: 0, right: 0, child: widget.botton!),
        ),
        Positioned(
          top: resizeHeight - 1,
          left: 0,
          right: 0,
          height: 3,
          child: InkWell(
            mouseCursor: SystemMouseCursors.resizeUpDown,
            child: Listener(
              onPointerMove: (PointerMoveEvent event) {
                setState(() {
                  resizeHeight += event.delta.dy;
                });
              },
              child: Container(
                //color: Colors.white.withValues(alpha:0.01),
                color: Colors.green.withValues(alpha: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
