import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeToolbarRender extends StatefulWidget {
  const IdeToolbarRender({super.key});

  @override
  State<IdeToolbarRender> createState() => _IdeToolbarRenderState();
}

class _IdeToolbarRenderState extends State<IdeToolbarRender> {
  @override
  void initState() {
    Ide.initState("IdeToolbarRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Ide.toolbar == null) {
      return const SizedBox.shrink();
    }

    IdeSize size = Ide.toolbar!.size;
    IdePosition position = Ide.toolbar!.position;


    return Positioned(
      top: position.top,
      left: position.left,
      right: position.right,
      height: size.height,
      child: Container(
        margin: Ide.toolbar!.margin,
        padding: Ide.toolbar!.padding,
        decoration: Ide.toolbar!.decoration,
        clipBehavior: Ide.toolbar!.decoration != null ? Ide.toolbar!.clipBehavior : Clip.none,
        child: Ide.toolbar!.render(),
      ),
    );
  }
}
