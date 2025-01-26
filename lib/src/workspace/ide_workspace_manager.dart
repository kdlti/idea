import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menubar/top/ide_menubar_top_button.dart';

/// A classe IdeWorkspaceManager gerencia o espaço de trabalho do IDE e o conteúdo exibido dentro dele.
/// Ele permite registrar diferentes tipos de conteúdo, criar novas instâncias desses tipos e exibir o conteúdo correspondente em guias.
/// Ele também permite que o usuário feche as guias de conteúdo e alterne entre as guias abertas. A classe é responsável por gerenciar
/// os menus e painéis laterais e inferiores associados ao conteúdo exibido. Ele fornece métodos para adicionar,
/// remover e selecionar o conteúdo no espaço de trabalho.
class IdeWorkspaceManager {
  // Mapa de configuração de conteúdo com o tipo de conteúdo como chave e a configuração correspondente como valor.
  final Map<String, IdeContent> _mapContent = {};

  // Lista de conteúdo exibido no espaço de trabalho do IDE.
  final List<IdeContent> listContent = [];

  // Identificador do conteúdo inicial.
  final String initId;

  // Construtor da classe IdeWorkspaceManager.
  IdeWorkspaceManager({this.initId = "default"});

  // Obtém o índice do conteúdo ativo na lista de conteúdo.
  int get activeIndex {
    int index = -1;

    // Verifica se há conteúdo ativo e se a lista de conteúdo não está vazia.
    if (Ide.activeContent != null && listContent.isNotEmpty) {
      // Itera por todos os itens da lista de conteúdo.
      for (int i = 0; i < listContent.length; i++) {
        // Compara o UID do conteúdo ativo com o UID do conteúdo atual da iteração.
        if (listContent[i].uid == Ide.activeContent!.uid) {
          // Se forem iguais, define o índice para o valor atual do contador e encerra o loop.
          index = i;
          break;
        }
      }
    }
    return index;
  }

  // Retorna a quantidade de instâncias do tipo de conteúdo especificado na lista de conteúdo.
  int _totalType(IdeContent ideContent) {
    int count = 0;
    for (var item in listContent) {
      if (item.render.runtimeType == ideContent.render.runtimeType) {
        count++;
      }
    }
    return count;
  }

  // Retorna a posição do conteúdo especificado na lista de conteúdo.
  int _position(IdeContent content) {
    int result = -1;
    for (int i = 0; i < listContent.length; i++) {
      if (listContent[i].uid == content.uid) {
        result = i;
        break;
      }
    }
    return result;
  }

  // Define o menu direito e o painel inferior com base nas configurações do conteúdo atual.
  void _infoAndPanelBottom(IdeContent content) {
    // Se o conteúdo atual tiver um menu direito, define o menu direito correspondente.
    if (content.menubarRight != null) {
      // Se o conteúdo atual tiver um painel direito, define a lista de painéis direitos correspondente.
      if (content.panelsRight != null) {
        content.menubarRight!.listPanelRight = [];
        if (content.panelsRight!.children.isNotEmpty) {
          for (var item in content.panelsRight!.children) {
            content.menubarRight!.listPanelRight.add(item);
          }
        }
      }
    }

    // Se o conteúdo atual tiver um menu inferior, define o menu inferior correspondente.
    if (content.menubarBottom != null) {
      // Se o conteúdo atual tiver um painel inferior, define a lista de painéis inferiores correspondente.
      if (content.panelsBottom != null) {
        content.menubarBottom!.listPanelsBottom = [];
        if (content.panelsBottom!.children.isNotEmpty) {
          for (var item in content.panelsBottom!.children) {
            content.menubarBottom!.listPanelsBottom.add(item);
          }
        }
      }
    }

    // Define a barra de guias com base nas configurações do conteúdo atual.
    Ide.menubarTop = content.menubarTop;
  }

  // Registra um novo tipo de conteúdo no IDE e cria uma nova instância do tipo de conteúdo para exibição.
  final Set<String> registeredContentIds = {};

  void register(IdeContent ideContent) {
    if (!registeredContentIds.add(ideContent.uid)) {
      throw Exception("Conteúdo já registrado.");
    }

    try {
      // Verifica se o tipo de conteúdo já está registrado.
      if (_mapContent.containsKey(ideContent.uid)) {
        ideLog.e(
          '''
════════ Exception caught by IdeWorkspace.content A════════
Você está tentando registrar '${ideContent.id}' conteúdo que já está em uso.
''',
          error: {"IdeContent": ideContent.id},
          stackTrace: StackTrace.current,
        );
      } else {
        // Se o tipo de conteúdo ainda não estiver registrado, o registra.
        _mapContent[ideContent.id] = ideContent;

        // Cria uma nova instância do tipo de conteúdo.
        if (ideContent.id == initId) {
          if (ideContent.menubarTop != null) {
            ideContent.button = IdeMenubarTopButton(
              label: ideContent.menubarTop!.tabbar!.label,
              tooltip: ideContent.menubarTop!.tabbar!.tooltip ?? "",
              icon: ideContent.menubarTop!.tabbar!.icon,
              showTooltip: ideContent.menubarTop!.tabbar!.tooltip != null && ideContent.menubarTop!.tabbar!.tooltip!.isNotEmpty,
              alowClose: ideContent.menubarTop!.tabbar!.alowClose,
              onActive: () {
                setActiveContent(ideContent);
              },
              onClose: () {
                remove(ideContent);
              },
              uid: ideContent.uid,
            );
          }

          _infoAndPanelBottom(ideContent);
          _insert(activeIndex + 1, ideContent);
        }
      }
    } catch (e, s) {
      ideLog.e('Erro ao registrar conteúdo', error: e, stackTrace: s);
    }
  }

  // Adiciona uma nova aba de conteúdo com base no tipo de conteúdo especificado.
  void showContent(String id) {
    Ide.hidePanelRight();
    Ide.panelBottomHide();

    IdeContent? ideContent = _mapContent[id];

    if (ideContent != null) {
      String label = "ideContent.label";
      String id = ideContent.id;

      IdeContent newIdeContent = ideContent;

      // Verifica se o conteúdo tem uma guia de menu superior.
      // Se sim, cria uma nova guia de menu superior com base nas configurações do conteúdo.
      if (ideContent.menubarTop != null) {
        // Cria um novo rótulo para a guia de menu superior.
        int totalType = _totalType(ideContent);

        // Verifica se o rótulo é maior que 0
        if (totalType > 0) {
          // Adiciona o total de instâncias do tipo de conteúdo ao rótulo.
          label += " ($totalType)";
          id += "($totalType)";
        }

        // Criar uma nova instância do tipo de conteúdo.
        IdeContent newIdeContent = ideContent.copyWith(id: id);

        // Cria uma nova guia de menu superior com base nas configurações do conteúdo.
        newIdeContent.button = IdeMenubarTopButton(
          label: label,
          tooltip: ideContent.menubarTop!.tabbar!.tooltip!,
          icon: ideContent.menubarTop!.tabbar!.icon,
          alowClose: ideContent.menubarTop!.tabbar!.alowClose,
          showTooltip: ideContent.menubarTop!.tabbar!.tooltip != null && ideContent.menubarTop!.tabbar!.tooltip!.isNotEmpty,
          onActive: () {
            setActiveContent(newIdeContent);
          },
          onClose: () {
            remove(newIdeContent);
          },
          uid: newIdeContent.uid,
        );
      }

      _infoAndPanelBottom(newIdeContent);

      // Insere o novo conteúdo na lista de conteúdo.
      _insert(activeIndex + 1, newIdeContent);
    }
  }

  void showContentTab({required String id, required String uid, String? label}) {
    Ide.hidePanelRight();
    Ide.panelBottomHide();
    IdeContent? ideContent = _mapContent[id];

    if (ideContent != null) {
      String newLabel = label ?? ideContent.menubarTop!.tabbar!.label;
      String tooltip = ideContent.menubarTop != null ? ideContent.menubarTop!.tabbar!.tooltip! : "";
      bool showTooltip = ideContent.menubarTop != null &&
          ideContent.menubarTop!.tabbar!.tooltip != null &&
          ideContent.menubarTop!.tabbar!.tooltip!.isNotEmpty;

      if (newLabel.length > 16) {
        tooltip = newLabel;
        showTooltip = true;
        newLabel = "${newLabel.substring(0, 16)}...";
      }

      IdeContent newIdeContent = ideContent.copyWith(id: uid);
      newIdeContent.button = IdeMenubarTopButton(
        label: newLabel,
        tooltip: tooltip,
        icon: ideContent.menubarTop!.tabbar!.icon,
        showTooltip: showTooltip,
        alowClose: ideContent.menubarTop!.tabbar!.alowClose,
        onActive: () {
          setActiveContent(newIdeContent);
        },
        onClose: () {
          remove(newIdeContent);
        },
        uid: newIdeContent.uid,
      );
      _infoAndPanelBottom(newIdeContent);
      _insert(activeIndex + 1, newIdeContent);
    }
  }

  Map<String, int> contentIndexMap = {};

  void _insert(int index, IdeContent content) {
    if (!contentIndexMap.containsKey(content.uid)) {
      listContent.add(content);
      contentIndexMap[content.uid] = listContent.length - 1;
    }
    setActiveContentId(content.uid);
  }

  void remove(IdeContent content) {
    int index = _position(content);
    if (index != -1) {
      // Remove o conteúdo da lista
      listContent.removeAt(index);

      // Remove o ID do Set de IDs registrados
      registeredContentIds.remove(content.uid);

      // Atualiza o Map de índices
      contentIndexMap.remove(content.uid);
      // Recriar o índice para refletir a nova ordem
      _rebuildContentIndexMap();

      // Configura o próximo conteúdo ativo se possível
      if (index > 0) {
        setActiveContent(listContent[index - 1]);
      } else if (listContent.isNotEmpty) {
        setActiveContent(listContent[0]);
      } else {
        Ide.activeContent = null; // Nenhum conteúdo restante
      }
    }
  }

  // Método auxiliar para reconstruir o map de índices
  void _rebuildContentIndexMap() {
    contentIndexMap.clear();
    for (int i = 0; i < listContent.length; i++) {
      contentIndexMap[listContent[i].uid] = i;
    }
  }

  void setActiveContentId(String uid) {
    for (var item in listContent) {
      if (item.uid == uid) {
        setActiveContent(item);
        break;
      }
    }
  }

  /// Ativa o conteúdo especificado, atualizando painéis e UI.
  /// - Parâmetros:
  ///   - content: Conteúdo a ser ativado.
  void setActiveContent(IdeContent content) {
    Ide.panelRight = null;
    Ide.panelBottom = null;
    Ide.activeContent = content;
    _infoAndPanelBottom(content);

    if (Ide.hasMenubarTop) {
      Ide.menubarTop!.redrawButtonState();
    }

    Ide.globalRedraw();
  }

  List<Widget> get contents {
    List<Widget> result = [];
    for (var item in listContent) {
      result.add(item.render);
    }
    return result;
  }

  List<Widget> get tabs {
    List<Widget> result = [];
    for (var item in listContent) {
      result.add(item.button);
    }
    return result;
  }

  void dispose() {
    _mapContent.clear();
    listContent.clear();
    Ide.activeContent = null;
  }

  bool hasContentUid(String uid) {
    return _mapContent.containsKey(uid);
  }
}
