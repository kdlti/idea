import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/ide_state.dart';
import 'package:idea/src/workspace/ide_workspace_manager.dart';

class IdeMiddleWare extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    if (Ide.workspaceManager != null && Ide.activeRoute != page!.name) {
      Ide.dispose();
    }
    Ide.mounted = false;
    Ide.focusNode = FocusNode();
    Ide.state = IdeState();
    Ide.workspaceManager = IdeWorkspaceManager();
    Ide.panelRight = null;
    Ide.panelBottom = null;
    Ide.activeRoute = page!.name;
    Ide.layer = IdeLayer();

    //TODO:: Implementar verificação de ACL
    return super.onPageCalled(page);
  }
}

class IdeModule {
  final GetPageBuilder child;
  final String route;
  final Object? arguments;
  final IdeBinding? binding;

  List<GetMiddleware>? middlewares;

  IdeModule({
    required this.child,
    required this.route,
    this.middlewares,
    this.arguments,
    this.binding,
  });

  GetPage get page {
    middlewares ??= [];
    middlewares!.add(IdeMiddleWare());

    return GetPage(
      name: route,
      page: child,
      middlewares: middlewares,
      arguments: arguments,
      binding: binding,
    );
  }
}
