/*
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

/// Classe IdeConfig gerencia o tamanho e a posição de objetos em um ambiente de desenvolvimento integrado (IDE).
class IdeConfig {
  // Mapa para armazenar tamanhos de objetos com base em seus hashCodes
  final Map<int, IdeSize> _sizes = {};

  // Mapa para armazenar posições de objetos com base em seus hashCodes
  final Map<int, IdePosition> _positions = {};

  /// Verifica se um objeto com um determinado hashCode existe nos mapas _sizes ou _positions.
  bool exist(int hashCode) {
    return _sizes.containsKey(hashCode) || _positions.containsKey(hashCode);
  }

  /// Retorna o tamanho do objeto com o hashCode fornecido.
  /// Se o objeto não existir, retorna o tamanho padrão fornecido.
  IdeSize getSize(int hashCode, IdeSize size) {
    return _sizes.putIfAbsent(hashCode, () => size);
  }

  /// Define o tamanho do objeto com o hashCode fornecido.
  void setSize(int hashCode, IdeSize size) {
    _sizes[hashCode] = size;
  }

  /// Retorna a posição do objeto com o hashCode fornecido.
  /// Se o objeto não existir, retorna a posição padrão fornecida.
  IdePosition getPosition(int hashCode, IdePosition position) {
    return _positions.putIfAbsent(hashCode, () => position);
  }

  /// Define a posição do objeto com o hashCode fornecido.
  void setPosition(int hashCode, IdePosition position) {
    _positions[hashCode] = position;
  }

  /// Limpa os mapas _sizes e _positions.
  void dispose() {
    _sizes.clear();
    _positions.clear();
  }
}
*/
