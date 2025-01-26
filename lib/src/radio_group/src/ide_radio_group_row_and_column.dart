import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/radio_group/src/ide_radio_group_item.dart';

// IdeRadioGroupRowAndColumn exibe uma lista de radio buttons em uma grade de linhas e colunas
class IdeRadioGroupRowAndColumn extends StatefulWidget {
  // As restrições de tamanho da grade
  final BoxConstraints constraints;

  // O número máximo de colunas na grade
  final int maxColumns;

  // As opções a serem exibidas
  final List<IdeOptionValue> options;

  // O estado do formulário ao qual o grupo de radio buttons pertence
  final FormFieldState<String> state;

  // A largura do item do radio button
  final double width;

  // Função chamada quando um item do radio button é alterado
  final ValueChanged<String?>? onChanged;

  const IdeRadioGroupRowAndColumn({
    super.key,
    required this.constraints,
    required this.maxColumns,
    required this.options,
    required this.state,
    required this.width,
    required this.onChanged,
  });

  @override
  State<IdeRadioGroupRowAndColumn> createState() => _IdeRadioGroupRowAndColumnState();
}

// Estado do widget IdeRadioGroupRowAndColumn
class _IdeRadioGroupRowAndColumnState extends State<IdeRadioGroupRowAndColumn> {
  // Método que constrói a grade de linhas e colunas
  Column buildWidget() {
    List<Widget> listChildren = [];
    int len = widget.options.length;
    int maxItems = len % widget.maxColumns;

    // Percorre as opções e agrupa-as em linhas
    for (int i = 0; i < len - maxItems; i += widget.maxColumns) {
      List listGroup = widget.options.sublist(i, i + widget.maxColumns);
      List<Widget> listLabelValue = [];
      for (var element in listGroup) {
        // Cria um item do radio button e adiciona à linha
        Widget item = Container(
          width: widget.width,
          constraints: BoxConstraints(maxWidth: widget.constraints.maxWidth),
          child: IdeRadioGroupItem(
            state: widget.state,
            groupValue: widget.state.value,
            ideOptionValue: element,
            onChanged: widget.onChanged,
          ),
        );
        listLabelValue.add(item);
      }
      listChildren.add(Row(children: listLabelValue));
    }

    // Adiciona as opções restantes em uma linha final
    if (maxItems != 0) {
      List listGroup = widget.options.sublist(widget.options.length - maxItems);
      List<Widget> listLabelValue = [];
      for (var element in listGroup) {
        // Cria um item do radio button e adiciona à linha final
        Widget item = Container(
          width: widget.width,
          constraints: BoxConstraints(maxWidth: widget.constraints.maxWidth),
          child: IdeRadioGroupItem(
            state: widget.state,
            groupValue: widget.state.value,
            ideOptionValue: element,
            onChanged: widget.onChanged,
          ),
        );
        listLabelValue.add(item);
      }
      listChildren.add(Row(children: listLabelValue));
    }

    // Adiciona uma mensagem de erro se houver erro no estado do formulário
    if (widget.state.hasError) {
      listChildren.add(Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          widget.state.errorText!,
          style: const TextStyle(color: Colors.red),
        ),
      ));
    }

    return Column(
      children: listChildren,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget();
  }
}
