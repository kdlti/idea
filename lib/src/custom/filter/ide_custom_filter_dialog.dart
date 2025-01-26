import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/custom/filter/ide_custom_filter_footer.dart';
import 'package:idea/src/custom/filter/ide_custom_filter_group.dart';
import 'package:idea/src/custom/filter/ide_custom_filter_header.dart';

class IdeCustomFilterDialog extends StatefulWidget {
  final Future<List<IdeCustomFilterValue>> Function() future;
  final IdeCustomFilterConfig config;
  final ValueChanged<IdeCustomFilterResult> onFilter;

  const IdeCustomFilterDialog({
    super.key,
    required this.future,
    required this.config,
    required this.onFilter,
  });

  @override
  State<IdeCustomFilterDialog> createState() => _IdeCustomFilterDialogState();
}

class _IdeCustomFilterDialogState extends State<IdeCustomFilterDialog> {
  final double _baseHeight = 95; // Altura base sem os filtros
  List<IdeCustomFilterValue> filterValues = []; // Armazena os valores dos filtros

  @override
  void initState() {
    super.initState();
    _loadFilters();
  }

  // Método para carregar os filtros de forma assíncrona
  void _loadFilters() async {
    var fetchedFilters = await widget.future();
    setState(() {
      filterValues = fetchedFilters;
    });
  }

  @override
  Widget build(BuildContext context) {
    // A altura é calculada dinamicamente com base no número de filtros
    double height = _baseHeight + (filterValues.length * 55);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 800,
        height: height, // Utiliza a altura calculada
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            // Usar Column pode ajudar a simplificar o layout
            children: [
              const IdeCustomFilterHeader(),
              Expanded(
                // Garante que a lista possa rolar se necessário
                child: ListView.builder(
                  itemCount: filterValues.length,
                  itemBuilder: (context, index) {
                    var filterValue = filterValues[index];
                    return IdeCustomFilterGroup(
                      filterValue: filterValue,
                      config: widget.config,
                      onChanged: () {},
                      onRemove: (value) {
                        setState(() {
                          filterValues.removeAt(index); // Remove o filtro da lista
                        });
                      },
                    );
                  },
                ),
              ),
              IdeCustomFilterFooter(
                onPressed: () {
                  setState(() {
                    filterValues.add(
                      IdeCustomFilterValue(
                        index: filterValues.length,
                        logic: 'AND',
                        op: 'EQ',
                        field: 'field',
                        values: ['value'],
                        subFilters: [],
                      ),
                    ); // Adiciona um novo filtro
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
