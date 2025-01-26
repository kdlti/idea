import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdePanelBottomRender extends StatefulWidget {
  const IdePanelBottomRender({super.key});

  @override
  State<IdePanelBottomRender> createState() => _IdePanelBottomRenderState();
}

class _IdePanelBottomRenderState extends State<IdePanelBottomRender> {
  late Widget component;

  @override
  void initState() {
    Ide.initState("IdePanelBottomRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Ide.panelBottom == null) {
      return const SizedBox.shrink();
    }

    IdeSize size = Ide.panelBottom!.size;
    IdePosition position = Ide.panelBottom!.position;

    return Positioned(
      left: position.left,
      right: position.right,
      bottom: position.bottom,
      height: size.height,
      child: Container(
        padding: Ide.panelBottom!.padding,
        margin: Ide.panelBottom!.margin,
        decoration: Ide.panelBottom!.decoration,
        clipBehavior: Ide.panelBottom!.decoration != null ? Ide.panelBottom!.clipBehavior! : Clip.none,
        child: Ide.panelBottom!.render(),
      ),
    );
  }
}
