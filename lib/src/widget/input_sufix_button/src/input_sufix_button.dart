import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeInputSufixButton extends StatefulWidget {
  final String label;
  final String? tooltip;
  final String value;
  final ValueChanged<String> onPressed;
  final VoidCallback? onClear;
  final IconData icon;
  final bool isDense;

  const IdeInputSufixButton({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
    this.onClear,
    required this.icon,
    this.tooltip,
    this.isDense = true,
  });

  @override
  State<IdeInputSufixButton> createState() => IdeInputSufixButtonState();
}

class IdeInputSufixButtonState extends State<IdeInputSufixButton> {
  late bool isButtonEnabled;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    isButtonEnabled = widget.value.isNotEmpty;
    _textEditingController = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _handleTextChanged(String text) {
    setState(() {
      isButtonEnabled = text.isNotEmpty;
    });
  }

  void _handleSearchPressed() {
    if (isButtonEnabled) {
      widget.onPressed(_textEditingController.text);
    }
  }

  void reset() {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: _handleTextChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        labelText: widget.label,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 45,
          minHeight: 45,
        ),
        suffixIcon: SizedBox(
          width: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_textEditingController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _textEditingController.clear();
                      _handleTextChanged('');
                      if (widget.onClear != null) {
                        widget.onClear!();
                      }
                    });
                  },
                  tooltip: widget.tooltip,
                ),
              IdeIconButton(
                iconData: Icons.clear,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                onPressed: () {
                  setState(() {
                    _textEditingController.clear();
                    _handleTextChanged('');
                    if (widget.onClear != null) {
                      widget.onClear!();
                    }
                  });
                },
                tooltip: widget.tooltip,
              ),
              Opacity(
                opacity: isButtonEnabled ? 1 : 0.5,
                child: IdeIconButton(
                  iconData: widget.icon,
                  onPressed: isButtonEnabled ? _handleSearchPressed : null,
                  tooltip: widget.tooltip,
                  iconColor: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 8)
            ],
          ),
        ),
      ),
    );
  }
}
