import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/radio_group/src/ide_radio_group_row_and_column.dart';

// Widget que exibe um grupo de radio buttons em uma grade simples
class IdeRadioGroupFormField extends FormField<String> {
  // O valor inicial do formulário
  @override
  final String? initialValue;

  // As opções a serem exibidas
  final List<IdeOptionValue> options;

  // A largura mínima do item do radio button
  final double minWidth;

  // A largura máxima do item do radio button
  final double maxWidth;

  // O texto de erro a ser exibido
  final String? errorText;

  // Função chamada quando um item do radio button é alterado
  final ValueChanged<String?>? onChanged;

  IdeRadioGroupFormField({
    super.key,
    super.onSaved,
    super.validator,
    this.initialValue,
    required this.options,
    this.minWidth = 230,
    this.maxWidth = 230,
    this.errorText,
    this.onChanged,
  }) : super(
    initialValue: initialValue,
    builder: (FormFieldState<String> state) {
      // Método que constrói a grade de radio buttons
      dynamic rowAndColumn(BoxConstraints constraints) {
        int maxColumns = (constraints.maxWidth / maxWidth).round();
        double columnMaxWidth = constraints.maxWidth / maxColumns;

        BoxConstraints boxConstraints = BoxConstraints(maxWidth: columnMaxWidth);
        if (boxConstraints.maxWidth > maxWidth) {
          boxConstraints = BoxConstraints(maxWidth: maxWidth);
        }

        return IdeRadioGroupRowAndColumn(
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
