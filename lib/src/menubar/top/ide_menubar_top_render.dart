import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeMenubarTopRender extends StatefulWidget {
  const IdeMenubarTopRender({super.key});

  @override
  State<IdeMenubarTopRender> createState() => _IdeMenubarTopRenderState();
}

class _IdeMenubarTopRenderState extends State<IdeMenubarTopRender> {
  @override
  void initState() {
    Ide.initState("IdeMenubarTopRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Ide.menubarTop == null) {
      return const SizedBox.shrink();
    }

    IdeSize size = Ide.menubarTop!.size;
    IdePosition position = Ide.menubarTop!.position;

    return Positioned(
      left: position.left,
      right: position.right,
      top: position.top,
      height: size.height,
      child: Container(
        padding: Ide.menubarTop!.padding,
        margin: Ide.menubarTop!.margin,
        decoration: Ide.menubarTop!.decoration,
        clipBehavior: Ide.menubarTop!.decoration != null ? Ide.menubarTop!.clipBehavior : Clip.none,
        child: Ide.menubarTop!.render(),
      ),
    );
  }
}
