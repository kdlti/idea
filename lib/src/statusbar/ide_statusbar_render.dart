import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeStatusbarRender extends StatefulWidget {
  const IdeStatusbarRender({super.key});

  @override
  IdeStatusbarRenderState createState() => IdeStatusbarRenderState();
}

class IdeStatusbarRenderState extends State<IdeStatusbarRender> {
  @override
  void initState() {
    Ide.initState("IdeStatusbarRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Ide.statusbar == null) {
      return const SizedBox.shrink();
    }

    IdeSize size = Ide.statusbar!.size;
    IdePosition position = Ide.statusbar!.position;

    return Positioned(
      bottom: position.bottom,
      left: position.left,
      right: position.right,
      height: size.height,
      child: Container(
        padding: Ide.statusbar!.padding,
        margin: Ide.statusbar!.margin,
        decoration: Ide.statusbar!.decoration,
        clipBehavior: Ide.statusbar!.decoration!= null ? Ide.statusbar!.clipBehavior : Clip.none,
        child: Ide.statusbar!.render(),
      ),
    );
  }
}
