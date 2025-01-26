import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/module/ide_module_render.dart';
import 'package:idea/src/workspace/ide_workspace_manager.dart';

/// Widget que representa o workspace da IDE.
class IdeWorkspace extends StatelessWidget {
  /// Lista de conteúdos da IDE.
  final List<IdeContent> contents;

  /// Rota atual utilizada pela IDE.
  final String route;

  /// ID inicial para o gerenciador de workspace.
  final String initId;

  /// Construtor do IdeWorkspace.
  ///
  /// Recebe os conteúdos, a rota e o ID inicial necessários para configurar o workspace.
  IdeWorkspace({
    super.key,
    required this.contents,
    required this.route,
    required this.initId,
  }) {



    // Inicializa o gerenciador de workspace com o ID inicial fornecido.
    Ide.workspaceManager = IdeWorkspaceManager(
      initId: initId,
    );

    // Registra cada conteúdo no gerenciador de workspace, se ainda não estiver registrado.
    for (IdeContent ideContent in contents) {
      if (!Ide.workspaceManager!.hasContentUid(ideContent.id)) {
        Ide.workspaceManager!.register(ideContent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define o UID do menu selecionado com base na rota atual, usando segurança de API.
    //Ide.selectedMenuUid = ApiSecurity.uidSha1(route);
    Ide.selectedMenuUid = route;

    // Marca a IDE como montada.
    Ide.mounted = true;

    // Retorna o renderizador do módulo da IDE.
    return const IdeModuleRender();
  }
}