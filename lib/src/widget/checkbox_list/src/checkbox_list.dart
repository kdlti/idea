import 'package:flutter/material.dart';
import 'package:idea/src/widget/checkbox_list/package.dart';
import 'package:idea/src/widget/checkbox_list/src/checkbox_list_layout.dart';

// Widget que exibe um grupo de radio buttons em uma grade simples
class IdeCheckboxList extends FormField<List<IdeCheckboxListOption>> {
  // O valor inicial do formulário
  final List<IdeCheckboxListOption>? initialValue;

  // As opções a serem exibidas
  final List<IdeCheckboxListOption> options;

  // A largura mínima do item do radio button
  final double minWidth;

  // A largura máxima do item do radio button
  final double maxWidth;

  // O texto de erro a ser exibido
  final String? errorText;

  // Função chamada quando um item do radio button é alterado
  final ValueChanged<List<IdeCheckboxListOption>?>? onChanged;

  IdeCheckboxList({super.key,
    super.onSaved,
    super.validator,
    this.initialValue = const [],
    required this.options,
    this.minWidth = 230,
    this.maxWidth = 230,
    this.errorText,
    this.onChanged,
  }) : super(
    initialValue: initialValue,
    builder: (FormFieldState<List<IdeCheckboxListOption>> state) {
      // Método que constrói a grade de radio buttons
      dynamic rowAndColumn(BoxConstraints constraints) {
        int maxColumns = (constraints.maxWidth / maxWidth).round();
        double columnMaxWidth = constraints.maxWidth / maxColumns;

        BoxConstraints boxConstraints = BoxConstraints(maxWidth: columnMaxWidth);
        if (boxConstraints.maxWidth > maxWidth) {
          boxConstraints = BoxConstraints(maxWidth: maxWidth);
        }

        return IdeCheckboxListLayout(
          initialValue: initialValue,
          options: options,
          maxColumns: maxColumns,
          constraints: boxConstraints,
          width: (constraints.maxWidth / maxColumns),
          state: state,
          onChanged: onChanged,
        );
      }

      // Usa um LayoutBuilder para passar as restrições de tamanho para o método rowAndColumn
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return rowAndColumn(constraints);
        },
      );
    },
  );
}
