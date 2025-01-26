/// Representa a paginação de uma API, contendo informações de limite, página
/// atual, total de páginas, etc.
class IdeTablePageInfo {
  /// Limite máximo de itens por página.
  int limit;

  /// Índice (ou número) da próxima página.
  int next;

  /// Página atual.
  int page;

  /// Total de páginas disponíveis.
  int pages;

  /// Índice (ou número) da página anterior.
  int previous;

  /// Total de itens retornados.
  int total;

  /// Cria uma instância de [IdeTablePageInfo].
  IdeTablePageInfo({
    this.limit = 1000,
    this.next = 0,
    this.page = 1,
    this.pages = 1,
    this.previous = 0,
    this.total = 0,
  });

  /// Cria uma instância de [IdeTablePageInfo] a partir de um [Map<String, dynamic>].
  factory IdeTablePageInfo.fromJson(Map<String, dynamic> json) {
    return IdeTablePageInfo(
      limit: json['limit'] as int,
      next: json['next'] as int,
      page: json['page'] as int,
      pages: json['pages'] as int,
      previous: json['previous'] as int,
      total: json['total'] as int,
    );
  }

  /// Converte a instância atual de [IdeTablePageInfo] em um [Map<String, dynamic>].
  Map<String, dynamic> get params {
    return {
      'limit': limit,
      'page': page,
    };
  }
  /// Converte a instância atual de [IdeTablePageInfo] em um [Map<String, dynamic>].
  Map<String, dynamic> get pagination {
    return {
      'limit': limit,
      'next': next,
      'page': page,
      'pages': pages,
      'previous': previous,
      'total': total,
    };
  }

  /// Verifica se há uma próxima página.
  bool get hasNext {
    return next > 0;
  }

  /// Verifica se há uma página anterior.
  bool get hasPrevious {
    return previous > 0;
  }

  /// Retorna uma representação em [String] do objeto [IdeTablePageInfo].
  @override
  String toString() {
    return 'IdeTablePageInfo(limit: $limit, next: $next, page: $page, pages: $pages, previous: $previous, total: $total)';
  }
}
