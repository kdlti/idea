import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:idea/package.dart';
import 'package:idea/src/custom/filter/filter_dropdown_condition.dart';
import 'package:idea/src/custom/filter/filter_dropdown_fields.dart';
import 'package:idea/src/custom/filter/filter_dropdown_option.dart';
import 'package:idea/src/custom/filter/ide_custom_filter_selected.dart';

class IdeCustomFilterGroup extends StatefulWidget {
  final IdeCustomFilterValue filterValue;
  final VoidCallback onChanged;
  final ValueChanged<IdeCustomFilterValue> onRemove;
  final IdeCustomFilterConfig config;

  IdeCustomFilterGroup({
    super.key,
    required this.filterValue,
    required this.onChanged,
    required this.onRemove,
    required this.config,
  });

  @override
  State<IdeCustomFilterGroup> createState() => _IdeCustomFilterGroupState();
}

class _IdeCustomFilterGroupState extends State<IdeCustomFilterGroup> {
  final filterActive = IdeCustomFilterActive();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        Container(
          alignment: Alignment.center,
          width: 120,
          child: (widget.filterValue.index == 0)
              ? const Text(
                  "ONDE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )
              : FlutterSwitch(
                  activeText: " E",
                  inactiveText: "OU ",
                  value: widget.filterValue.logic == "AND" ? true : false,
                  valueFontSize: 12,
                  width: 50,
                  height: 22,
                  borderRadius: 20,
                  padding: 0,
                  activeTextColor: Colors.black87,
                  activeTextFontWeight: FontWeight.bold,
                  inactiveTextFontWeight: FontWeight.bold,
                  inactiveTextColor: Colors.black87,
                  activeToggleColor: Colors.red.withValues(alpha: 0.1),
                  inactiveToggleColor: Colors.green.withValues(alpha: 0.1),
                  activeColor: Colors.transparent,
                  inactiveColor: Colors.transparent,
                  inactiveIcon: const Icon(Icons.arrow_forward, size: 15, color: Colors.black87),
                  activeIcon: const Icon(Icons.arrow_back, size: 15, color: Colors.black87),
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      widget.filterValue.logic = val ? "AND" : "OR";
                      widget.onChanged();
                    });
                  },
                ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: FilterDropdownFields(
                      config: widget.config,
                      filterActive: filterActive,
                      onChanged: () {
                        setState(() {});
                      },
                    ),
                  ),
                  if (filterActive.field != null)
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      constraints: const BoxConstraints(maxWidth: 170),
                      child: FilterDropdownCondition(
                        filterActive: filterActive,
                        onChanged: () {
                          setState(() {});
                        },
                      ),
                    ),
                  if (filterActive.condition != null)
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: FilterDropdownOption(
                          filterActive: filterActive,
                          onChanged: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  if (filterActive.condition == null) const Spacer(),
                  if (widget.filterValue.index != 0)
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      width: 30,
                      height: 30,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            widget.onRemove(widget.filterValue);
                          },
                          // Personalize a forma aqui
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Raio das bordas arredondadas
                          ),
                          // A criança do InkWell é o ícone que você deseja mostrar
                          child: const Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
