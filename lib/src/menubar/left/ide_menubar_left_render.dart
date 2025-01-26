import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeMenubarLeftRender extends StatefulWidget {
  const IdeMenubarLeftRender({super.key});

  @override
  State<IdeMenubarLeftRender> createState() => _IdeMenubarLeftRenderState();
}

class _IdeMenubarLeftRenderState extends State<IdeMenubarLeftRender> {
  @override
  void initState() {
    Ide.initState("IdeMenubarLeftRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(Ide.menubarLeft == null){
      return const SizedBox.shrink();
    }

    Ide.menubarLeft!.resize();
    IdeSize size = Ide.menubarLeft!.size;
    IdePosition position = Ide.menubarLeft!.position;
    IdeMenubarLeftStyle? style = Ide.menubarLeft!.style;

    return Positioned(
      top: position.top,
      bottom: position.bottom,
      left: position.left,
      width: size.width,
      child: Container(
        padding: Ide.menubarLeft!.padding,
        margin: Ide.menubarLeft!.margin,
        decoration: Ide.menubarLeft!.decoration,
        clipBehavior: Ide.menubarLeft!.decoration != null ? Ide.menubarLeft!.clipBehavior : Clip.none,
        child: Ide.menubarLeft!.render(),
      ),
    );
  }
}
