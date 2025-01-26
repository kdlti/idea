import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

/// A classe `IdeAppbar` representa a barra de aplicativos (AppBar) de uma IDE.
///
/// Ela gerencia a renderização, posicionamento, tamanho e visibilidade da barra de aplicativos dentro da interface da IDE.
/// Também leva em consideração outros componentes da IDE, como menus e painéis, para ajustar seu posicionamento adequadamente.
class IdeAppbar {
  /// Função que retorna o widget a ser renderizado dentro da barra de aplicativos.
  ///
  /// Geralmente, é a função que constrói a interface visual da AppBar.
  final IdeFunction<Widget> child;

  /// Representa a posição atual da barra de aplicativos na interface.
  ///
  /// Usado para determinar onde a barra será desenhada na tela.
  final IdePosition position = IdePosition();

  /// Representa o tamanho atual (largura e altura) da barra de aplicativos.
  final IdeSize size = IdeSize();

  /// Indica se a barra de aplicativos é visível ou não.
  bool visible;

  /// Define como a barra de aplicativos é deslocada horizontalmente por outros componentes, como menus ou painéis.
  final IdePushedByHorizontal pushedByHorizontal;

  /// Identificador único gerado para a barra de aplicativos usando SHA-1.
  //final String uid = ApiSecurity.uidSha1("appbar");
  final String uid = "appbar";

  /// Identificador simples para a barra de aplicativos.
  final String id = "appbar";

  /// Altura da barra de aplicativos. Se não especificado, o valor padrão é `40.0`.
  final double? height;

  /// Padding interno da barra de aplicativos.
  final EdgeInsetsGeometry? padding;

  /// Margem externa da barra de aplicativos.
  final EdgeInsetsGeometry? margin;

  /// Decoração visual da barra de aplicativos, como cores de fundo, bordas, etc.
  final BoxDecoration? decoration;

  /// Define o comportamento de recorte da barra de aplicativos.
  final Clip clipBehavior;

  /// Construtor para a classe `IdeAppbar`.
  ///
  /// Parâmetros:
  /// - [child]: Função obrigatória que retorna o widget a ser renderizado dentro da barra de aplicativos.
  /// - [visible]: Indica se a barra de aplicativos deve ser visível ou não. Padrão é `true`.
  /// - [height]: Altura da barra de aplicativos. Padrão é `40.0`.
  /// - [pushedByHorizontal]: Define como a barra é deslocada horizontalmente por outros componentes. Padrão é uma instância padrão de `IdePushedByHorizontal`.
  /// - [padding]: Padding interno da barra de aplicativos.
  /// - [margin]: Margem externa da barra de aplicativos.
  /// - [decoration]: Decoração visual da barra de aplicativos.
  IdeAppbar({
    required this.child,
    this.visible = true,
    this.height,
    this.pushedByHorizontal = const IdePushedByHorizontal(),
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior = Clip.antiAlias,
  }) {
    resize();
  }

  /// Redimensiona e reposiciona a barra de aplicativos com base em seu tema e nas posições dos painéis e menus da IDE.
  ///
  /// Calcula a altura total da barra, considerando a margem, e ajusta a posição com base na visibilidade e posição
  /// de outros componentes da IDE, como a barra de menus, menus laterais e painéis.
  void resize() {
    double totalHeight = height ?? 40.0;
    if (margin != null) {
      // Resolve a margem em relação à direção do texto (esquerda para a direita).
      final EdgeInsets resolvedMargin = margin!.resolve(TextDirection.ltr);
      // Adiciona as margens superior e inferior à altura total.
      totalHeight += resolvedMargin.top + resolvedMargin.bottom;
    }
    // Define a altura calculada no tamanho da barra de aplicativos.
    size.height = totalHeight;
    // Reinicia a posição para valores padrão.
    position.reset();

    // Ajusta a posição horizontal (esquerda) se o menu esquerdo estiver visível e deslocando a barra.
    if (Ide.hasMenubarLeft && Ide.menubarLeftVisible && pushedByHorizontal.menubarLeft) {
      position.left = Ide.menubarLeft!.position.left + Ide.menubarLeft!.size.width;
    }
    // Ajusta a posição horizontal (esquerda) se o painel esquerdo estiver visível e deslocando a barra.
    if (Ide.hasPanelLeft && Ide.panelLeftVisible && pushedByHorizontal.panelLeft) {
      position.left = position.left + Ide.panelLeft!.position.left + Ide.panelLeft!.size.width;
    }

    // Ajusta a posição horizontal (direita) se o menu direito estiver visível e deslocando a barra.
    if (Ide.hasMenubarRight && Ide.menubarRightVisible && pushedByHorizontal.menubarRight) {
      position.right = position.left + Ide.menubarRight!.position.right + Ide.menubarRight!.size.width;
    }
    // Ajusta a posição horizontal (direita) se o painel direito estiver visível e deslocando a barra.
    if (Ide.hasPanelRight && Ide.panelRightVisible && pushedByHorizontal.panelRight) {
      position.right = Ide.panelRight!.position.right + Ide.panelRight!.size.width;
    }
  }

  /// Cache do widget renderizado para evitar reconstruções desnecessárias.
  Widget? rendered;

  /// Renderiza o widget da barra de aplicativos.
  ///
  /// Se o widget já foi renderizado anteriormente, retorna o cache. Caso contrário, chama a função [child] para
  /// construir o widget e armazena no cache.
  Widget render() {
    return rendered ??= child();
  }
}
