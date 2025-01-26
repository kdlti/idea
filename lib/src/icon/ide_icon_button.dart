import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Um botão de ícone personalizável que utiliza o [IdeIcon] e suporta estados de hover, pressionado e desabilitado.
class IdeIconButton extends StatefulWidget {
  /// O ícone a ser exibido, usando [IconData].
  final IconData? iconData;

  /// O ícone SVG a ser exibido, fornecido como uma string SVG.
  final String? iconSvg;

  /// Callback a ser executado quando o botão é pressionado.
  final VoidCallback? onPressed;

  /// Texto opcional para o `Tooltip`.
  final String? tooltip;

  /// Indica se o botão está desabilitado.
  final bool disabled;

  // Cores e estilos para estados normal, hover, pressionado e desabilitado.

  /// Cor de fundo no estado normal.
  final Color? background;

  /// Cor de fundo no estado de hover.
  final Color? backgroundHover;

  /// Cor de fundo no estado pressionado.
  final Color? backgroundPressed;

  /// Cor de fundo no estado desabilitado.
  final Color? backgroundDisabled;

  /// Cor da borda no estado normal.
  final Color? borderColor;

  /// Cor da borda no estado de hover.
  final Color? borderColorHover;

  /// Cor da borda no estado pressionado.
  final Color? borderColorPressed;

  /// Cor da borda no estado desabilitado.
  final Color? borderColorDisabled;

  /// Cor do ícone no estado normal.
  final Color? iconColor;

  /// Cor do ícone no estado de hover.
  final Color? iconColorHover;

  /// Cor do ícone no estado pressionado.
  final Color? iconColorPressed;

  /// Cor do ícone no estado desabilitado.
  final Color? iconColorDisabled;

  /// Margem externa ao redor do botão.
  final EdgeInsetsGeometry? margin;

  /// Largura do botão.
  final double width;

  /// Altura do botão.
  final double height;

  final double iconSize;

  /// Largura da borda.
  final double borderWidth;

  /// Raio da borda para arredondamento.
  final BorderRadiusGeometry? borderRadius;

  /// Espaçamento interno ao redor do ícone.
  final EdgeInsetsGeometry? padding;

  /// Cria um botão de ícone personalizável com um `Tooltip` opcional.
  ///
  /// Pelo menos um entre [iconData] ou [iconSvg] deve ser fornecido.
  const IdeIconButton({
    Key? key,
    this.iconData,
    this.iconSvg,
    required this.onPressed,
    this.tooltip,
    this.disabled = false,
    this.background,
    this.backgroundHover,
    this.backgroundPressed,
    this.backgroundDisabled,
    this.borderColor,
    this.borderColorHover,
    this.borderColorPressed,
    this.borderColorDisabled,
    this.iconColor,
    this.iconColorHover,
    this.iconColorPressed,
    this.iconColorDisabled,
    this.margin,
    this.padding,
    this.width = 22.0,
    this.height = 22.0,
    this.iconSize = 16.0,
    this.borderWidth = 0.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
  })  : assert(iconData != null || iconSvg != null, 'É necessário fornecer iconData ou iconSvg'),
        super(key: key);

  @override
  _IdeIconButtonState createState() => _IdeIconButtonState();
}

class _IdeIconButtonState extends State<IdeIconButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  /// Obtém a cor atual baseada no estado do botão.
  /// Retorna [disabled] se o botão está desabilitado, [pressed] se está pressionado,
  /// [hover] se está em hover, ou [normal] caso contrário.
  Color _getCurrentColor(
    Color normal,
    Color hover,
    Color pressed,
    Color disabled,
  ) {
    if (widget.disabled) return disabled;
    if (_isPressed) return pressed;
    if (_isHovering) return hover;
    return normal;
  }

  @override
  Widget build(BuildContext context) {
    // Obter o tema atual para usar valores padrão, se necessário.
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconTheme = theme.iconTheme;

    // Determina as cores atuais baseadas no estado.
    Color currentBackground = _getCurrentColor(
      widget.background ?? colorScheme.surface, // Cor padrão de fundo
      widget.backgroundHover ?? colorScheme.primary.withValues(alpha: 0.1), // Hover padrão
      widget.backgroundPressed ?? colorScheme.primary.withValues(alpha: 0.2), // Pressionado
      widget.backgroundDisabled ?? colorScheme.onSurface.withValues(alpha: 0.1), // Desabilitado
    );

    Color currentBorderColor = _getCurrentColor(
      widget.borderColor ?? Colors.transparent, // Sem borda por padrão
      widget.borderColorHover ?? Colors.transparent, // Sem borda por padrão
      widget.borderColorPressed ?? Colors.transparent, // Sem borda por padrão
      widget.borderColorDisabled ?? Colors.transparent, // Sem borda por padrão
    );

    Color currentIconColor = _getCurrentColor(
      widget.iconColor ?? iconTheme.color!, // Cor padrão do ícone
      widget.iconColorHover ?? colorScheme.primary, // Cor de ícone no hover
      widget.iconColorPressed ?? colorScheme.primaryContainer, // Cor de ícone pressionado
      widget.iconColorDisabled ?? iconTheme.color!.withValues(alpha: 0.3), // Cor do ícone no estado desabilitado
    );

    // Renderiza o conteúdo do ícone, usando SVG se disponível.
    Widget iconContent;
    if (widget.iconSvg != null) {
      iconContent = SizedBox(
        width: widget.iconSize,
        height: widget.iconSize,
        child: SvgPicture.string(
          widget.iconSvg!,
          colorFilter: ColorFilter.mode(currentIconColor, BlendMode.srcIn),
          width: widget.iconSize,
          height: widget.iconSize,
        ),
      );
    } else if (widget.iconData != null) {
      iconContent = Icon(
        widget.iconData,
        color: currentIconColor,
        size: widget.iconSize,
      );
    } else {
      iconContent = const SizedBox.shrink(); // Retorno vazio se não houver ícone
    }

    // O widget só é interativo se não estiver desabilitado.
    Widget buttonContent = GestureDetector(
      onTapDown: (_) {
        if (!widget.disabled) setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        if (!widget.disabled) {
          setState(() => _isPressed = false);
          widget.onPressed?.call();
        }
      },
      onTapCancel: () {
        if (!widget.disabled) setState(() => _isPressed = false);
      },
      child: Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: currentBackground,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.iconSize / 2),
          border: Border.all(
            color: currentBorderColor,
            width: widget.borderWidth,
          ),
        ),
        child: Center(child: iconContent),
      ),
    );

    // Se o tooltip for fornecido, envolve o botão com ele.
    return MouseRegion(
      onEnter: (_) {
        if (!widget.disabled) setState(() => _isHovering = true);
      },
      onExit: (_) {
        if (!widget.disabled) setState(() => _isHovering = false);
      },
      cursor: widget.disabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: widget.tooltip != null
          ? Tooltip(
              message: widget.tooltip!,
              child: buttonContent,
            )
          : buttonContent,
    );
  }
}
