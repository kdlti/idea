import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeModuleRender extends StatefulWidget {
  const IdeModuleRender({super.key});

  @override
  State<IdeModuleRender> createState() => _IdeModuleRenderState();
}

class _IdeModuleRenderState extends State<IdeModuleRender> {
  @override
  void initState() {
    Ide.initState("IdeModuleRender", this);
    super.initState();
  }

  List<Widget> render() {
    Ide.layer!.reset();
    Ide.layer!.context = context;
    Ide.setState = setState;
    List<Widget> result = Ide.layer!.render();
    Ide.globalRedraw();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: render()),
      ),
    );
  }
}
