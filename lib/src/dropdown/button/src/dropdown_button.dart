import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';

class IdeDropdownButton extends StatefulWidget {
  final String label;
  final String? initialValue;
  final String buttonLabel;
  final String errorMessage;
  final void Function(String) onSubmitted;
  final bool allowReset;
  final String? regexPattern;
  final String? regexErrorMessage;

  const IdeDropdownButton({
    super.key,
    required this.label,
    this.initialValue,
    required this.buttonLabel,
    required this.errorMessage,
    required this.onSubmitted,
    this.allowReset = true,
    this.regexPattern,
    this.regexErrorMessage,
  });

  @override
  State<IdeDropdownButton> createState() => _IdeInputButtonState();
}

class _IdeInputButtonState extends State<IdeDropdownButton> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController controller;
  final List<String> _list = [
    'Opção teste 1',
    'Opção teste 2',
    'Opção teste 3',
    'Opção teste 4',
  ];

  final RxBool _isActiveButton = false.obs;

  bool get isActiveButton => _isActiveButton.value;

  set isActiveButton(bool value) => _isActiveButton.value = value;

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return widget.errorMessage;
    } else if (widget.regexPattern != null) {
      final regex = RegExp(widget.regexPattern!);
      if (!regex.hasMatch(value)) {
        return widget.regexErrorMessage ?? widget.errorMessage;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
    isActiveButton = widget.initialValue?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: IdeDropdown<String>(
                    hintText: 'Selecione',
                    items: _list,
                    //initialItem: _list[0],
                    excludeSelected: false,
                    onChanged: (value) {},
                    listItemPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    expandedHeaderPadding: const EdgeInsets.all(10),
                    closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    canCloseOutsideBounds: true,
                    decoration: IdeDropdownDecoration(
                      errorStyle: const TextStyle(color: Colors.transparent),
                      headerStyle: const TextStyle(color: Colors.black, fontSize: 14),
                      hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
                      listItemStyle: const TextStyle(color: Colors.black, fontSize: 14),
                      closedErrorBorderRadius: const BorderRadius.all(Radius.circular(4)),
                      closedBorderRadius: const BorderRadius.all(Radius.circular(4)),
                      expandedBorderRadius: const BorderRadius.all(Radius.circular(4)),
                      expandedBorder: Border.all(color: Theme.of(context).colorScheme.primary),
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
                ),
                Positioned(
                  left: 9,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(widget.label, style: Theme.of(context).textTheme.labelMedium!),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Obx(
              () => TextButton(
                onPressed: isActiveButton
                    ? () {
                        if (formKey.currentState!.validate()) {
                          widget.onSubmitted(controller.text);
                          if (widget.allowReset) {
                            controller.clear();
                            isActiveButton = false;
                          }
                        }
                      }
                    : null,
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary, // Cor do texto do botão
                  backgroundColor: isActiveButton
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface, // Cor de fundo do botão
                  textStyle: Theme.of(context).textTheme.labelMedium, // Estilo do texto do botão
                ),
                child: Text(widget.buttonLabel),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
