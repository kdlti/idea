
import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/custom/filter/ide_custom_filter_dialog.dart';

enum IdeCustomFilterType {
  input,
  select,
  selectMultiple,
  date,
  dateRange,
  number,
  numberRange,
  boolean,
}

class IdeCustomFilter extends StatefulWidget {
  final Future<List<IdeCustomFilterValue>> Function() future;
  final IdeCustomFilterConfig config;
  final ValueChanged<IdeCustomFilterResult> onFilter;

  const IdeCustomFilter({
    super.key,
    required this.future,
    required this.config,
    required this.onFilter,
  });

  @override
  State<IdeCustomFilter> createState() => _IdeCustomFilterState();
}

class _IdeCustomFilterState extends State<IdeCustomFilter> {
  int filterCount = 2;
  bool isHovered = false; // Adicionado para controlar o estado de hover

  String get filterText {
    if (filterCount == 0) {
      return "Filtro";
    } else if (filterCount == 1) {
      return "1 Filtro";
    } else {
      return "$filterCount Filtros";
    }
  }

  @override
  Widget build(BuildContext context) {
    /*Color backgroundColor = filterCount > 0 ? Theme.of(context).hoverColor : Colors.transparent;
    Color borderColor = Theme.of(context).colorScheme.primary;
    Color textColor = Theme.of(context).colorScheme.primary;
    Color iconColor = Theme.of(context).colorScheme.primary;
    Color iconClearColor = const Color(0XFFcdcafa);*/

    Color backgroundColor = filterCount > 0 ? Colors.blueAccent.withValues(alpha: 0.1) : Colors.transparent;
    Color borderColor = Colors.blueAccent;
    Color textColor = Colors.black87;
    Color iconColor = Colors.black87;
    Color iconClearColor = const Color(0XFFfff6ec);

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.white30, // Fundo cinza transparente
          builder: (context) => IdeCustomFilterDialog(
            future: widget.future,
            config: widget.config,
            onFilter: widget.onFilter,
          ),
          barrierLabel: 'Fechar', // Rótulo para o botão de fechar
        );
      },
      child: SizedBox(
        height: 22,
        child: MouseRegion(
          onEnter: (event) => setState(() => isHovered = true),
          onExit: (event) => setState(() => isHovered = false),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: borderColor),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.filter_list, size: 16, color: iconColor),
                    const SizedBox(width: 2),
                    Text(filterText, style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Positioned(
                top: 3,
                right: 2,
                child: Visibility(
                  visible: isHovered && filterCount > 0, // Torna visível apenas se hover e houver filtros
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent, // Remove fundo para evitar sobreposição visual indesejada
                      child: IdeCustomIconButton(
                        icon: Icons.clear,
                        width: 18,
                        height: 18,
                        decoration: IdeIconButtonDecoration(
                          color: iconClearColor,
                          colorHover: iconClearColor,
                          iconColor: iconColor,
                          iconColorHover: iconColor,
                          iconSize: 14,
                        ),
                        onPressed: () => setState(() => filterCount = 0), // Reseta o filtro para 0
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
