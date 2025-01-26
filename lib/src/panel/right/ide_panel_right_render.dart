import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdePanelRightRender extends StatefulWidget {
  const IdePanelRightRender({super.key});

  @override
  State<IdePanelRightRender> createState() => IdePanelRightRenderState();
}

class IdePanelRightRenderState extends State<IdePanelRightRender> {
  @override
  void initState() {
    Ide.initState("IdePanelRightRender", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Ide.panelRight == null) {
      return const SizedBox.shrink();
    }
    IdeSize size = Ide.panelRight!.size;
    IdePosition position = Ide.panelRight!.position;


    Ide.activeContent!.panelRightManager.middlewaresOnPanelShow();

    return Positioned(
      top: position.top,
      bottom: position.bottom,
      right: position.right,
      width: size.width,
      child: Container(
        alignment: Alignment.topLeft,
        height: Get.height,
        padding: Ide.panelRight!.padding,
        margin: Ide.panelRight!.margin,
        decoration: Ide.panelRight!.decoration,
        clipBehavior: Ide.panelRight!.decoration != null ? Ide.panelRight!.clipBehavior! : Clip.none,
        child: Ide.panelRight!.render(),
      ),
    );
  }
}
