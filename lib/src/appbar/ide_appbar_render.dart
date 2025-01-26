import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

/// O widget `IdeAppbarRender` é usado para renderizar a barra de aplicativos dentro da IDE.
/// Ele posiciona e estiliza a barra de acordo com as especificações fornecidas.
class IdeAppbarRender extends StatefulWidget {
  /// Cria uma instância do `IdeAppbarRender`.
  const IdeAppbarRender({super.key});

  /// Cria o estado mutável para este widget.
  @override
  State<IdeAppbarRender> createState() => _IdeAppbarRenderState();
}

/// Estado mutável para o widget `IdeAppbarRender`.
class _IdeAppbarRenderState extends State<IdeAppbarRender> {
  /// Método chamado quando este objeto é inserido na árvore de widgets.
  @override
  void initState() {
    super.initState();
    // Inicializa o estado da barra de aplicativos no contexto da IDE.
    Ide.initState("IdeAppbarRender", this);
  }

  // Método chamado quando este objeto é removido da árvore de widgets.
  @override
  void dispose() {
    // Limpa qualquer recurso associado ao estado da barra de aplicativos.
    Ide.disposeState<IdeAppbarRender>();
    super.dispose();
  }

  /// Constrói a interface do usuário para este widget.
  @override
  Widget build(BuildContext context) {
    // Verifica se a barra de aplicativos está definida; caso contrário, retorna um widget vazio.
    if (Ide.appbar == null) {
      return const SizedBox.shrink();
    }

    // Obtém a barra de aplicativos atual, seu tamanho e posição.
    final IdeAppbar appbar = Ide.appbar!;
    final IdeSize size = appbar.size;
    final IdePosition position = appbar.position;

    // Posiciona e renderiza a barra de aplicativos com base em suas especificações.
    return Positioned(
      top: position.top,
      // Define a distância do topo.
      left: position.left,
      // Define a distância da esquerda.
      right: position.right,
      // Define a distância da direita.
      height: size.height,
      // Define a altura da barra de aplicativos.
      child: Container(
        clipBehavior: appbar.decoration != null ? appbar.clipBehavior : Clip.none,
        // Define o comportamento de recorte.
        padding: appbar.padding,
        // Define o preenchimento interno.
        margin: appbar.margin,
        // Define a margem externa.
        decoration: appbar.decoration,
        // Aplica a decoração (ex: cores, bordas).
        child: appbar.render(),
      ),
    );
  }
}
