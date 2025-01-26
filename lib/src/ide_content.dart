import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menubar/top/ide_menubar_top_button.dart';
import 'package:idea/src/panel/bottom/ide_panel_bottom_manager.dart';
import 'package:idea/src/panel/right/ide_panel_right_manager.dart';

/// Callback que recebe uma instância de [IdeContent] opcionalmente.
typedef IdeContentEvent = void Function(IdeContent content)?;

/// Classe principal que representa o conteúdo de uma IDE.
///
/// Essa classe encapsula diversas configurações de layout, como painéis,
/// barras de menu, appbar, toolbar, statusbar, etc.
class IdeContent<T> {
  /// Função que retorna um widget para ser renderizado na tela.
  ///
  /// Geralmente é uma função que constrói a página principal (ex.: `() => SomePage()`).
  final IdeFunction page;

  /// Identificador único desse conteúdo.
  ///
  /// Em geral, é usado para fins de registro e seleção.
  final String id;

  /// Gerencia os painéis do lado direito da IDE.
  ///
  /// Pode conter múltiplos painéis (e.g. console, logs, propriedades).
  final IdePanelsRight? panelsRight;

  /// Gerencia a barra de menu do lado direito.
  ///
  /// Pode conter botões ou ícones de acesso a configurações, etc.
  final IdeMenubarRight? menubarRight;

  /// Gerencia os painéis na parte inferior da IDE.
  ///
  /// Pode conter painéis como terminal, debug console, etc.
  final IdePanelsBottom? panelsBottom;

  /// Gerencia a barra de menu na parte inferior.
  ///
  /// Ideal para exibir botões de ação ou guias para trocar de painel.
  final IdeMenubarBottom? menubarBottom;

  /// Gerencia a barra de menu do lado esquerdo.
  ///
  /// Pode conter ícones de navegação, por exemplo.
  final IdeMenubarLeft? menubarLeft;

  /// Gerencia o painel do lado esquerdo.
  ///
  /// Ex.: Explorer de arquivos, estrutura de pastas, etc.
  final IdePanelLeft? panelLeft;

  /// Toolbar principal do aplicativo.
  ///
  /// Geralmente fica logo abaixo do AppBar, contendo ações rápidas.
  final IdeToolbar? toolbar;

  /// Barra de status exibida geralmente no rodapé.
  ///
  /// Pode conter informações de status, como linha/coluna, modos ativos etc.
  final IdeStatusbar? statusbar;

  /// AppBar principal.
  ///
  /// Geralmente exibe o título da aplicação, ícones de busca, etc.
  final IdeAppbar? appbar;

  final bool progressBar;

  /// Botão que pode ser exibido na barra de menu superior.
  ///
  /// Esse botão é inicializado posteriormente e pode desencadear ações no topo da IDE.
  late IdeMenubarTopButton button;

  /// UID interno usado para diferenciar o conteúdo na aplicação.
  ///
  /// Inicialmente definido como o valor de [id].
  String uid = "";

  /// Gerenciador dos painéis inferiores.
  ///
  /// Responsável por registrar e manipular o estado dos painéis (ex.: expandir, fechar, selecionar).
  IdePanelBottomManager panelBottomManager = IdePanelBottomManager();

  /// UID do painel inferior selecionado.
  ///
  /// Mantém referência de qual painel inferior está visível/selecionado no momento.
  String panelBottomSelected = "";

  /// Gerenciador dos painéis direitos.
  ///
  /// Responsável por registrar e manipular o estado dos painéis (ex.: expandir, fechar, selecionar).
  IdePanelRightManager panelRightManager = IdePanelRightManager();

  /// Observável que armazena o UID do painel direito selecionado.
  ///
  /// É um [RxString] para reagir às mudanças de seleção e atualizar a interface.
  final RxString _panelRightSelected = ''.obs;

  /// Define o UID do painel direito selecionado e notifica o [Ide.sidenavManager].
  set panelRightSelected(String uid) {
    _panelRightSelected.value = uid;
    Ide.sidenavManager.selectUid(uid);
  }

  /// Retorna o UID do painel direito selecionado.
  String get panelRightSelected => _panelRightSelected.value;

  /// Gerencia a barra de menu superior.
  final IdeMenubarTop? menubarTop;

  /// Construtor principal de [IdeContent].
  ///
  /// Recebe a função [page], que descreve o widget principal,
  /// e diversos parâmetros opcionais de layout (menubars, toolbars, panels etc.).
  IdeContent({
    required this.page,
    required this.id,
    this.menubarTop,
    this.panelsRight,
    this.panelsBottom,
    this.menubarRight,
    this.menubarBottom,
    this.menubarLeft,
    this.panelLeft,
    this.toolbar,
    this.statusbar,
    this.appbar,
    this.progressBar = false,
  }) {
    uid = id;

    _initializePanelsRight();
    _initializePanelsBottom();
  }

  /// Inicializa os painéis do lado direito, definindo parâmetros padrão
  /// e registrando-os no [panelRightManager].
  void _initializePanelsRight() {
    if (panelsRight == null || panelsRight!.children.isEmpty) return;

    for (var panel in panelsRight!.children) {
      panel
        ..width ??= panelsRight!.width
        ..padding ??= panelsRight!.padding
        ..margin ??= panelsRight!.margin
        ..decoration ??= panelsRight!.decoration
        ..clipBehavior ??= panelsRight!.clipBehavior
        ..pushedByVertical ??= panelsRight!.pushedByVertical
        ..overlay = panelsRight!.overlay
        ..init();

      // Registra o painel no gerenciador.
      panelRightManager.register(panel);

      // Se não houver initId específico, a cada loop
      // estamos sobrescrevendo o panelRightSelected (selecionando o último painel).
      // Caso queira selecionar somente um, basta ajustar a lógica.
      panelRightSelected = panel.uid;

      // Se houver um initId definido e coincidir com o ID do painel,
      // marca o painel como inicializado e visível.
      if (panelsRight!.initId != null && panelsRight!.initId!.isNotEmpty && panelsRight!.initId == panel.id) {
        panel
          ..initialized = true
          ..visible = true;
        panelRightSelected = panel.uid;
      }
    }
  }

  /// Inicializa os painéis da parte inferior, definindo parâmetros padrão
  /// e registrando-os no [panelBottomManager].
  void _initializePanelsBottom() {
    if (panelsBottom == null || panelsBottom!.children.isEmpty) return;

    for (var panel in panelsBottom!.children) {
      panelBottomManager.register(panel);
      panel.initialized = false;

      // Se o initId do painel inferior bater com o ID do painel,
      // inicializamos e tornamos visível.
      if (panelsBottom!.initId.isNotEmpty && panelsBottom!.initId == panel.id) {
        panel
          ..initialized = true
          ..visible = true;
      }
    }
  }

  /// Cria uma cópia de [IdeContent] com a possibilidade de atualizar o [id].
  ///
  /// Mantém todas as demais propriedades inalteradas.
  IdeContent copyWith({
    required String id,
  }) {
    return IdeContent<T>(
      page: page,
      id: id,
      menubarTop: menubarTop,
      panelsRight: panelsRight,
      menubarRight: menubarRight,
      panelsBottom: panelsBottom,
      menubarBottom: menubarBottom,
      menubarLeft: menubarLeft,
      panelLeft: panelLeft,
      toolbar: toolbar,
      statusbar: statusbar,
      appbar: appbar,
      progressBar: progressBar,
    );
  }

  /// Armazena um valor do tipo [T] associado a este [IdeContent].
  ///
  /// Inicialmente, `_data` é `null`. Use [setData] para definir o valor.
  T? _data;

  /// Define o valor de [_data].
  void setData(T data) {
    _data = data;
  }

  /// Retorna o valor de [_data], lançando um [StateError] se for `null`.
  T get data {
    if (_data == null) {
      throw StateError('O _data está nulo. É necessário setar antes de acessar.');
    }
    return _data!;
  }

  /// Cache do widget retornado por [page].
  ///
  /// Se for nulo, será preenchido ao chamar [render] pela primeira vez.
  Widget? rendered;

  /// Retorna o widget principal (definido por [page]) utilizando lazy initialization.
  ///
  /// Uma vez instanciado, o widget fica em [rendered].
  Widget get render {
    return rendered ??= page();
  }
}
