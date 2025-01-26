import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea/package.dart';

import '../ide_library_null.dart' if (dart.library.html) 'dart:html' as html;

/// Um botão que permite alternar entre os modos de tela cheia e tela normal.
///
/// Este widget funciona em plataformas web, desktop e mobile.
/// Na web, utiliza a API de tela cheia do navegador.
/// Em plataformas móveis e desktop, utiliza o [SystemChrome] para ajustar o modo da interface do usuário.
///
/// O botão exibe um ícone que representa o estado atual (entrar ou sair da tela cheia).
/// Quando o cursor passa sobre o botão na web, o cursor muda para indicar que é clicável.
class IdeButtonToggleFullscreen extends StatefulWidget {
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignment;
  final String? fullscreen;
  final String? fullscreenExit;

  /// Cria uma instância de [IdeButtonToggleFullscreen].
  const IdeButtonToggleFullscreen({
    super.key,
    this.fullscreen,
    this.fullscreenExit,
    this.alignment = Alignment.topCenter,
    this.decoration = const BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      ),
    ),
  });

  @override
  State<IdeButtonToggleFullscreen> createState() => _IdeButtonToggleFullscreenState();
}

class _IdeButtonToggleFullscreenState extends State<IdeButtonToggleFullscreen> {
  /// Indica se a tela está em modo de tela cheia.
  ///
  /// Para plataformas web, verifica o estado real através da API do navegador.
  /// Para outras plataformas, mantém o estado interno.
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    // Inicializa o estado de tela cheia.
    _updateFullScreenState();

    // Adiciona um listener para mudanças de tela cheia na web.
    if (kIsWeb) {
      html.document.onFullscreenChange.listen((event) {
        _updateFullScreenState();
      });
    }
  }

  /// Atualiza o estado de tela cheia verificando o estado real.
  void _updateFullScreenState() {
    if (kIsWeb) {
      // Para web, verifica se há um elemento em tela cheia.
      bool fullscreen = html.document.fullscreenElement != null;

      setState(() {
        isFullScreen = fullscreen;
      });
    } else {
      // Para mobile e desktop, mantém o estado interno.
      // O estado é atualizado em _toggleFullScreen.
    }
  }

  /// Alterna entre entrar e sair do modo de tela cheia.
  Future<void> _toggleFullScreen() async {
    if (kIsWeb) {
      if (html.document.fullscreenElement != null) {
        // Se estiver em tela cheia, sai.
        html.document.exitFullscreen();
        // Atualiza o estado imediatamente.
        setState(() {
          isFullScreen = false;
        });
      } else {
        // Se não estiver em tela cheia, entra.
        html.document.documentElement?.requestFullscreen();
        // Atualiza o estado imediatamente.
        setState(() {
          isFullScreen = true;
        });
      }
      // O estado será verificado e atualizado novamente pelo listener em onFullscreenChange.
    } else {
      if (isFullScreen) {
        // Se estiver em tela cheia, sai.
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      } else {
        // Se não estiver em tela cheia, entra.
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      }
      // Atualiza o estado interno.
      setState(() {
        isFullScreen = !isFullScreen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IdeIconButton(
      iconData: isFullScreen ? Icons.fullscreen_exit_outlined : Icons.fullscreen_outlined,
      iconSvg: isFullScreen ? widget.fullscreenExit : widget.fullscreen,
      background: Colors.yellowAccent,
      onPressed: _toggleFullScreen,
      width: 30,
      height: 26,
      iconSize: 22,
      iconColor: Colors.red,
      borderRadius: widget.decoration?.borderRadius,
    );
  }
}
