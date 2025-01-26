import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/widget/checkbox_list/src/checkbox_list_item.dart';

// IdeRowAndColumn exibe uma lista de radio buttons em uma grade de linhas e colunas
class IdeCheckboxListLayout extends StatefulWidget {
  // As restrições de tamanho da grade
  final BoxConstraints constraints;

  // O valor inicial do formulário
  final List<IdeCheckboxListOption>? initialValue;

  // O número máximo de colunas na grade
  final int maxColumns;

  // As opções a serem exibidas
  final List<IdeCheckboxListOption> options;

  // O estado do formulário ao qual o grupo de radio buttons pertence
  final FormFieldState<List<IdeCheckboxListOption>> state;

  // A largura do item do radio button
  final double width;

  // Função chamada quando um item do radio button é alterado
  final ValueChanged<List<IdeCheckboxListOption>?>? onChanged;

  const IdeCheckboxListLayout({
    Key? key,
    required this.constraints,
    required this.maxColumns,
    required this.options,
    required this.state,
    required this.width,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<IdeCheckboxListLayout> createState() => _IdeCheckboxListLayoutState();
}

// Estado do widget IdeCheckboxListLayout
class _IdeCheckboxListLayoutState extends State<IdeCheckboxListLayout> {
  void isChecked(IdeCheckboxListOption optionItem) {
    for (IdeCheckboxListOption optionSelectedItem in widget.initialValue!) {
      if (optionSelectedItem.id == optionItem.id) {
        optionItem.value = optionSelectedItem.value;
      }
    }
  }

  void prepareChecked() {
    for (var optionItem in widget.options) {
      isChecked(optionItem);
    }
  }

  @override
  void initState() {
    prepareChecked();
    super.initState();
  }

  // Método que constrói a grade de linhas e colunas
  Column buildWidget() {
    List<Widget> listChildren = [];
    int len = widget.options.length;
    int maxItems = len % widget.maxColumns;

    // Percorre as opções e agrupa-as em linhas
    for (int i = 0; i < len - maxItems; i += widget.maxColumns) {
      List listGroup = widget.options.sublist(i, i + widget.maxColumns);
      List<Widget> listLabelValue = [];
      for (IdeCheckboxListOption optionItem in listGroup) {
        // Cria um item do radio button e adiciona à linha
        Widget item = Container(
          width: widget.width,
          constraints: BoxConstraints(maxWidth: widget.constraints.maxWidth),
          child: IdeCheckboxListItem(
            state: widget.state,
            optionItem: optionItem,
            listOptionsItem: widget.options,
            onChanged: (value) {
              widget.onChanged!(widget.options);
            },
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
          child: IdeCheckboxListItem(
            listOptionsItem: widget.options,
            state: widget.state,
            optionItem: element,
            onChanged: (value) {
              widget.onChanged!(widget.options);
            },
          ),
        );
        listLabelValue.add(item);
      }
      listChildren.add(Row(children: listLabelValue));
    }

    // Adiciona uma mensagem de erro se houver erro no estado do formulário
    if (widget.state.hasError) {
      listChildren.add(
        Text(
          widget.state.errorText!,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error, // A cor do erro do tema atual
            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize, // O tamanho do texto do tema atual
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listChildren,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget();
  }
}
