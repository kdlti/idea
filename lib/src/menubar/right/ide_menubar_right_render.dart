import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeMenubarRightRender extends StatefulWidget {
  const IdeMenubarRightRender({super.key});

  @override
  State<IdeMenubarRightRender> createState() => _IdeMenubarRightRenderState();
}

class _IdeMenubarRightRenderState extends State<IdeMenubarRightRender> {
  @override
  void initState() {
    Ide.initState("IdeMenubarRightRender", this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!Ide.hasMenubarRight) {
      return const SizedBox.shrink();
    }
    IdeSize size = Ide.menubarRight!.size;
    IdePosition position = Ide.menubarRight!.position;

    return Positioned(
      top: position.top,
      right: position.right,
      bottom: position.bottom,
      width: size.width,
      child: Container(
        padding: Ide.menubarRight!.padding,
        margin: Ide.menubarRight!.margin,
        decoration: Ide.menubarRight!.decoration,
        clipBehavior: Ide.menubarRight!.decoration != null ? Ide.menubarRight!.clipBehavior! : Clip.none,
        child: Ide.menubarRight!.render(),
      ),
    );
  }
}
