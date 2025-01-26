/// Arquivo stub para 'dart:html' em plataformas não-web.
///
/// Este arquivo evita erros de compilação em plataformas que não suportam 'dart:html'.
class Document {
  Element? get documentElement => null;

  get fullscreenElement => null;

  get onFullscreenChange => null;
  void exitFullscreen() {}
}

class Element {
  void requestFullscreen() {}
}

Document get document => Document();
