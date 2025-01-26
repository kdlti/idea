import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdePanelLeftRender extends StatefulWidget {
  const IdePanelLeftRender({super.key});

  @override
  State<IdePanelLeftRender> createState() => _IdePanelLeftRenderState();
}

class _IdePanelLeftRenderState extends State<IdePanelLeftRender> {
  late Widget component;

  @override
  void initState() {
    Ide.initState("IdePanelLeftRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Ide.panelLeft == null || !Ide.panelLeftVisible) {
      return const SizedBox.shrink();
    }

    if(Get.width <= 800){
      Ide.panelLeft!.visible = false;
      return const SizedBox.shrink();
    }

    IdeSize size = Ide.panelLeft!.size;
    IdePosition position = Ide.panelLeft!.position;

    return Positioned(
      top: position.top,
      left: position.left,
      bottom: position.bottom,
      width: size.width,
      child: Stack(
        children: [
          Container(
            padding: Ide.panelLeft!.padding,
            margin: Ide.panelLeft!.margin,
            decoration: Ide.panelLeft!.decoration,
            clipBehavior: Ide.panelLeft!.decoration != null ? Ide.panelLeft!.clipBehavior : Clip.none,
            child: Ide.panelLeft!.render(),
          ),
        ],
      ),
    );
  }
}
