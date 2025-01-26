import 'package:flutter/material.dart';
import 'package:idea/package.dart';

//TODO: Adicionar mensagem de erro em vermelho quando existir erro
class IdeDropdownLabel<T> extends StatelessWidget {
  /// Initial selected item from the list of [items].
  final dynamic initialItem;
  final String hintText;

  final List<IdeDropdownItem<dynamic>>? items;

  /// Called when the item of the [IdeDropdown] should change.
  final Function(dynamic)? onChanged;

  final String label;

  const IdeDropdownLabel({
    super.key,
    this.initialItem,
    this.items,
    this.onChanged,
    required this.label,
    this.hintText = 'Selecione',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 40,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: IdeDropdown<IdeDropdownItem<dynamic>>(
            validator: (value) {
              if (value == null) {
                return 'Campo obrigatório';
              }
              return null;
            },
            hintText: hintText,
            initialItem: initialItem,
            items: items,
            onChanged: onChanged,
            listItemPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            //canCloseOutsideBounds: true,
            headerBuilder: (context, item) {
              return Text(
                item.label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              );
            },
            expandedHeaderPadding: const EdgeInsets.only(left: 8, right: 6, top: 6, bottom: 6),
            //hideSelectedFieldWhenExpanded: false,
            //overlayHeight: 240,
            excludeSelected: false,
            decoration: IdeDropdownDecoration(
              noResultFoundStyle: const TextStyle(color: Colors.red, fontSize: 14),
              overlayScrollbarDecoration: ScrollbarThemeData(
                thickness: const WidgetStatePropertyAll(4),
                radius: const Radius.circular(4),
                thumbColor: const WidgetStatePropertyAll(Colors.grey),
                trackColor: WidgetStatePropertyAll(Colors.grey[200]),
              ),
              closedSuffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              expandedSuffixIcon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.grey,
              ),
              closedBorder: Border.all(color: Colors.grey[300]!, width: 1),
              closedBorderRadius: BorderRadius.circular(4),
              expandedBorder: Border.all(color: Colors.blueAccent, width: 1),
              expandedBorderRadius: BorderRadius.circular(4),
              closedErrorBorder: Border.all(color: Colors.red, width: 1),
              closedErrorBorderRadius: BorderRadius.circular(4),
              closedFillColor: Colors.white,
              expandedFillColor: Colors.white,
              headerStyle: const TextStyle(color: Colors.red, fontSize: 14),
              errorStyle: const TextStyle(color: Colors.red, fontSize: 14),
              listItemStyle: const TextStyle(color: Colors.black87, fontSize: 14),
              hintStyle: const TextStyle(color: Colors.blue, fontSize: 14),
              listItemDecoration:  ListItemDecoration(
                selectedColor: Colors.blueAccent.withValues(alpha: 0.4),
                highlightColor: Colors.blueAccent,
                splashColor: Colors.blueAccent
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 7,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.white],
                stops: [0.5, 0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: 13,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF5d6b71), height: 0),
            ),
          ),
        ),
      ],
    );
  }
}
