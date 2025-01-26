import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdeInputButton extends StatefulWidget {
  final String label;
  final String? initialValue;
  final String buttonLabel;
  final String errorMessage;
  final void Function(String) onSubmitted;
  final bool allowReset;
  final String? regexPattern;
  final String? regexErrorMessage;

  const IdeInputButton({
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
  State<IdeInputButton> createState() => _IdeInputButtonState();
}

class _IdeInputButtonState extends State<IdeInputButton> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController controller;

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
            child: TextFormField(
              controller: controller,
              validator: _emailValidator,
              onChanged: (value) => isActiveButton = value.isNotEmpty,
              decoration: InputDecoration(
                labelText: widget.label,
                contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(top: 4),
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
