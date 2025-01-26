class IdeException implements Exception {
  // Lista de mensagens de erro.
  final List<dynamic>? messages;

  // Caminho do campo ou recurso onde ocorreu o erro.
  // AclAuthorize: endpoint de autorização de acesso.
  final String path;

  IdeException({this.messages, required this.path});

  @override
  String toString() {
    final messageString = messages?.join(', ') ?? 'Sem mensagens de erro da API';
    return "IdeException at $path: $messageString";
  }
}