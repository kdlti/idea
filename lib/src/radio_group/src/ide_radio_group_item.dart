import 'package:flutter/material.dart';
import 'package:idea/package.dart';


// O IdeRadioGroupItem representa um item de radio button em um grupo de radio buttons
class IdeRadioGroupItem<T> extends StatefulWidget {
  // O valor do grupo de radio buttons
  final Object? groupValue;

  // A opção selecionável do item do radio button
  final IdeOptionValue ideOptionValue;

  // Função chamada quando o item do radio button é alterado
  final ValueChanged<String?>? onChanged;

  // O estado do formulário ao qual o grupo de radio buttons pertence
  final FormFieldState<String> state;

  const IdeRadioGroupItem({
    super.key,
    required this.groupValue,
    required this.ideOptionValue,
    required this.onChanged,
    required this.state,
  });

  @override
  State<IdeRadioGroupItem> createState() => _IdeRadioGroupItemState();
}

// Estado do widget IdeRadioGroupItem
class _IdeRadioGroupItemState extends State<IdeRadioGroupItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Radio button para selecionar a opção
        Radio<String>(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          // O valor da opção do item do radio button
          value: widget.ideOptionValue.value,
          // O valor do grupo de radio buttons
          groupValue: widget.state.value,
          onChanged: (value) {
            // Chama a função onChanged quando o valor é alterado
            widget.onChanged!(value);
            widget.state.didChange(value);
            widget.state.validate();
          },
        ),
        // Texto para exibir a opção
        InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            // Chama a função onChanged quando o texto é clicado
            widget.onChanged!(widget.ideOptionValue.value);
            widget.state.didChange(widget.ideOptionValue.value);
            widget.state.validate();
          },
          child: Text(widget.ideOptionValue.label),
        ),
      ],
    );
  }
}
