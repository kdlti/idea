import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Um widget que exibe um ícone, podendo ser um [IconData] ou um SVG fornecido como string.
///
/// O `IdeIcon` é responsável por renderizar o ícone, seja ele um ícone do Material Design ou um ícone SVG.
/// Você pode personalizar a cor e o tamanho do ícone.
///
/// ### Exemplo de uso:
///
/// ```dart
/// IdeIcon(
///   iconData: Icons.home,
///   color: Colors.blue,
///   size: 24.0,
/// )
/// ```
class IdeIcon extends StatelessWidget {
  /// O ícone a ser exibido, usando [IconData].
  final IconData? iconData;

  /// O ícone SVG a ser exibido, fornecido como uma string SVG.
  final String? iconSvg;

  /// A cor do ícone.
  final Color? color;

  /// O tamanho do ícone.
  final double? size;

  /// Cria um widget que exibe um ícone.
  ///
  /// É necessário fornecer [iconData] ou [iconSvg].
  const IdeIcon({
    Key? key,
    this.iconData,
    this.iconSvg,
    this.color,
    this.size,
  })  : assert(iconData != null || iconSvg != null,
  'É necessário fornecer iconData ou iconSvg'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconData != null) {
      // Renderiza o ícone usando IconData.
      return Icon(
        iconData,
        color: color,
        size: size,
      );
    } else if (iconSvg != null) {
      // Renderiza o ícone SVG.
      return SvgPicture.string(
        iconSvg!,
        colorFilter:
        color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
    } else {
      // Devido ao assert, este ponto não deve ser alcançado.
      return const SizedBox.shrink();
    }
  }
}
