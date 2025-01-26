import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeMenubarBottomRender extends StatefulWidget {
  const IdeMenubarBottomRender({super.key});

  @override
  State<IdeMenubarBottomRender> createState() => _IdeMenubarBottomRenderState();
}

class _IdeMenubarBottomRenderState extends State<IdeMenubarBottomRender> {
  @override
  void initState() {
    Ide.initState("IdeMenubarBottomRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Ide.hasMenubarBottom) {
      return const SizedBox.shrink();
    }
    IdeSize size = Ide.menubarBottom!.size;
    IdePosition position = Ide.menubarBottom!.position;

    return IdeVisibilityBuilder(
      condition: Ide.hasMenubarBottom,
      child: () => Positioned(
        left: position.left,
        right: position.right,
        bottom: position.bottom,
        height: size.height,
        child: Container(
          //padding: Ide.menubarBottom!.padding,
          //margin: Ide.menubarBottom!.margin,
          //decoration: Ide.menubarBottom!.decoration,
          //clipBehavior: Ide.menubarBottom!.decoration != null ? Ide.menubarBottom!.clipBehavior! : Clip.none,
          child: Ide.menubarBottom!.render(),
        ),
      ),
    );
  }
}
