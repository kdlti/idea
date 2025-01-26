import 'package:flutter/material.dart';
import 'package:idea/src/widget/checkbox_list/package.dart';

// O RadioItem representa um item de radio button em um grupo de radio buttons
class IdeCheckboxListItem<T> extends StatefulWidget {
  // A opção selecionável do item do radio button
  final IdeCheckboxListOption optionItem;

  // Função chamada quando o item do radio button é alterado
  final List<IdeCheckboxListOption>? listOptionsItem;

  // Função chamada quando o item do radio button é alterado
  final ValueChanged<List<IdeCheckboxListOption>?>? onChanged;

  // O estado do formulário ao qual o grupo de radio buttons pertence
  final FormFieldState<List<IdeCheckboxListOption>> state;

  const IdeCheckboxListItem({
    Key? key,
    required this.optionItem,
    required this.onChanged,
    required this.state,
    required this.listOptionsItem,
  }) : super(key: key);

  @override
  State<IdeCheckboxListItem> createState() => _IdeCheckboxListItemState();
}

// Estado do widget RadioItem
class _IdeCheckboxListItemState extends State<IdeCheckboxListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Radio button para selecionar a opção
        Checkbox(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashRadius: 0,
          // O valor da opção do item do radio button
          value: widget.optionItem.value,
          onChanged: (value) {
            // Chama a função onChanged quando o valor é alterado
            widget.optionItem.value = value;
            widget.onChanged!(widget.listOptionsItem);
            widget.state.didChange(widget.listOptionsItem);
            widget.state.validate();
          },
        ),
        // Texto para exibir a opção
        InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            widget.optionItem.value = !widget.optionItem.value;
            // Chama a função onChanged quando o texto é clicado
            widget.onChanged!(widget.listOptionsItem);
            widget.state.didChange(widget.listOptionsItem);
            widget.state.validate();
          },
          child: Text(
            widget.optionItem.label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
