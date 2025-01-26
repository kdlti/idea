import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/custom/filter/ide_custom_filter_selected.dart';

class FilterDropdownOption extends StatelessWidget {
  final IdeCustomFilterActive filterActive;
  final VoidCallback onChanged;

  final List<IdeDropdownItem> listFields = [
    IdeDropdownItem(label:'É', value: 'É'),
    IdeDropdownItem(label:'Não é', value: 'Não é'),
    IdeDropdownItem(label:'Está configurado', value: 'Está configurado'),
    IdeDropdownItem(label:'Não está configurado', value: 'Não está configurado'),
    IdeDropdownItem(label:'É igual a', value: 'É igual a'),
    IdeDropdownItem(label:'Não é igual a', value: 'Não é igual a'),
    IdeDropdownItem(label:'Contém', value: 'Contém'),
    IdeDropdownItem(label:'Não contém', value: 'Não contém'),
    IdeDropdownItem(label:'Inicia com', value: 'Inicia com'),
    IdeDropdownItem(label:'Termina com', value: 'Termina com'),
    IdeDropdownItem(label:'Está vazio', value: 'Está vazio'),
    IdeDropdownItem(label:'Não está vazio', value: 'Não está vazio'),
    IdeDropdownItem(label:'Maior que', value: 'Maior que'),
    IdeDropdownItem(label:'Maior ou igual a', value: 'Maior ou igual a'),
    IdeDropdownItem(label:'Menor que', value: 'Menor que'),
    IdeDropdownItem(label:'Menor ou igual a', value: 'Menor ou igual a'),
    IdeDropdownItem(label:'Entre', value: 'Entre'),
    IdeDropdownItem(label:'Hoje', value: 'Hoje'),
    IdeDropdownItem(label:'Ontem', value: 'Ontem'),
    IdeDropdownItem(label:'Últimos 7 dias', value: 'Últimos 7 dias'),
    IdeDropdownItem(label:'Últimos 30 dias', value: 'Últimos 30 dias'),
    IdeDropdownItem(label:'Este mês', value: 'Este mês'),
    IdeDropdownItem(label:'Mês passado', value: 'Mês passado'),
    IdeDropdownItem(label:'Este ano', value: 'Este ano'),
    IdeDropdownItem(label:'Ano passado', value: 'Ano passado'),
  ];

  FilterDropdownOption({
    super.key,
    required this.filterActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<IdeDropdownItem> listFields = filterActive.field!.listCondition.map((option) => IdeDropdownItem(label:option.label, value: option.label)).toList();
    switch (filterActive.field!.type) {
      case IdeCustomFilterType.input:
        return buildInput();
      case IdeCustomFilterType.select:
        List<IdeDropdownItem> listOptions = filterActive.field!.listOptions!.map((option) => IdeDropdownItem(label:option.label, value: option.label)).toList();
        return buildSelect(listOptions);
      case IdeCustomFilterType.selectMultiple:
        return buildSelectMultiple(listFields);
      case IdeCustomFilterType.date:
        return buildDate();
      case IdeCustomFilterType.dateRange:
        return buildDateRange();
      case IdeCustomFilterType.number:
        return buildNumber();
      case IdeCustomFilterType.numberRange:
        return buildNumberRange();
      case IdeCustomFilterType.numberRange:
        return buildBoolean();
      default:
        return Container();
    }
    return buildSelect(listFields);
  }

  Widget buildInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: SizedBox(
        height: 26,
        child: TextField(
          style: const TextStyle(fontSize: 15, color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Digite o valor',
            isDense: true,
            filled: true, // Garante que o fundo seja preenchido
            fillColor: Colors.white, // Define a cor de fundo como branco
            border: OutlineInputBorder(
              borderSide: BorderSide.none, // Bordas em vermelho por padrão
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none, // Bordas em vermelho por padrão
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: MouseRegion(
                    //onEnter: (event) => setState(() => _isHovering = true),
                    //onExit: (event) => setState(() => _isHovering = false),
                    cursor: SystemMouseCursors.click, // Muda o cursor para o estilo de clique
                    child: Container(
                      margin: const EdgeInsets.only(right: 1),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.07), // Muda a cor do ícone no hover
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Icon(
                        Icons.clear,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelect(List<IdeDropdownItem> listFields) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: IdeDropdown.search(
        hintText: 'Selecionar opção',
        items: listFields,
        onChanged: (value) {
          //log('changing value to: $value');
        },
        listItemPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        expandedHeaderPadding: const EdgeInsets.all(10),
        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        canCloseOutsideBounds: true,
        //initialItem: _listFields[0],
        decoration: IdeDropdownDecoration(
          errorStyle: const TextStyle(color: Colors.transparent),
          headerStyle: const TextStyle(color: Colors.black, fontSize: 14),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          listItemStyle: const TextStyle(color: Colors.black, fontSize: 14),
          closedErrorBorderRadius: const BorderRadius.all(Radius.circular(4)),
          closedBorderRadius: const BorderRadius.all(Radius.circular(4)),
          expandedBorderRadius: const BorderRadius.all(Radius.circular(4)),
          closedBorder: const Border(
            top: BorderSide(color: Colors.black12),
            bottom: BorderSide(color: Colors.black12),
            left: BorderSide(color: Colors.black12),
            right: BorderSide(color: Colors.black12),
          ),
          searchFieldDecoration: SearchFieldDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            //constraints: const BoxConstraints.tightFor(height: 30),
            contentPadding: const EdgeInsets.all(2),
            textStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 16),
            suffixIcon: (VoidCallback onClear) => InkWell(
              onTap: onClear,
              child: const Icon(Icons.clear, color: Colors.grey, size: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectMultiple(List<IdeDropdownItem> listFields) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: IdeDropdown<IdeDropdownItem>(
        hintText: 'Selecionar opção',
        items: listFields,
        onChanged: (value) {
          log('changing value to: $value');
        },
        listItemPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        expandedHeaderPadding: const EdgeInsets.all(10),
        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        canCloseOutsideBounds: true,
        //initialItem: _listFields[0],
        decoration: IdeDropdownDecoration(
          errorStyle: const TextStyle(color: Colors.transparent),
          headerStyle: const TextStyle(color: Colors.black, fontSize: 14),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          listItemStyle: const TextStyle(color: Colors.black, fontSize: 14),
          closedErrorBorderRadius: const BorderRadius.all(Radius.circular(4)),
          closedBorderRadius: const BorderRadius.all(Radius.circular(4)),
          expandedBorderRadius: const BorderRadius.all(Radius.circular(4)),
          closedBorder: const Border(
            top: BorderSide(color: Colors.black12),
            bottom: BorderSide(color: Colors.black12),
            left: BorderSide(color: Colors.black12),
            right: BorderSide(color: Colors.black12),
          ),
          searchFieldDecoration: SearchFieldDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            constraints: const BoxConstraints.tightFor(height: 30),
            contentPadding: const EdgeInsets.all(2),
            textStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 16),
            suffixIcon: (VoidCallback onClear) => InkWell(
              onTap: onClear,
              child: const Icon(Icons.clear, color: Colors.grey, size: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDate() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Data inicial',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Data final',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateRange() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Data inicial',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Data final',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNumber() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Digite o valor',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget buildNumberRange() {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Valor inicial',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Valor final',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoolean() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: IdeDropdown<IdeDropdownItem>(
        hintText: 'Selecionar opção',
        items: listFields,
        onChanged: (value) {
          log('changing value to: $value');
        },
        listItemPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        expandedHeaderPadding: const EdgeInsets.all(10),
        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        canCloseOutsideBounds: true,
        //initialItem: _listFields[0],
        decoration: const IdeDropdownDecoration(
          errorStyle: TextStyle(color: Colors.transparent),
          headerStyle: TextStyle(color: Colors.black, fontSize: 14),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          listItemStyle: TextStyle(color: Colors.black, fontSize: 14),
          closedErrorBorderRadius: BorderRadius.all(Radius.circular(4)),
          closedBorderRadius: BorderRadius.all(Radius.circular(4)),
          expandedBorderRadius: BorderRadius.all(Radius.circular(4)),
          closedBorder: Border(
            top: BorderSide(color: Colors.black12),
            bottom: BorderSide(color: Colors.black12),
            left: BorderSide(color: Colors.black12),
            right: BorderSide(color: Colors.black12),
          ),
          searchFieldDecoration: SearchFieldDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            constraints: BoxConstraints.tightFor(height: 30),
            contentPadding: EdgeInsets.all(2),
            textStyle: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
      ),
    );
  }
}
