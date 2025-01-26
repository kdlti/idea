import 'package:flutter/material.dart';
import 'package:idea/src/widget/radio_list/package.dart';

class IdeRadioList extends FormField<String> {
  final List<IdeRadioListOption> options;
  @override
  final String? initialValue;
  final String? Function(String?) validator;
  final String errorMessage;
  final void Function(String?) onChanged; // Adicione esta linha

  IdeRadioList({
    super.key,
    required this.options,
    required this.validator,
    required this.errorMessage,
    this.initialValue,
    required this.onChanged, // Adicione esta linha
  }) : super(
          initialValue: initialValue,
          validator: validator,
          builder: (FormFieldState<String> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...options.map((option) {
                  return IgnorePointer(
                    ignoring: option.enabled == false,
                    child: Opacity(
                      opacity: option.enabled == false ? 0.5 : 1,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            state.didChange(option.value);
                            validator(option.value);
                            onChanged(option.value);
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Radio<String>(
                                    value: option.value,
                                    groupValue: state.value,
                                    onChanged: (value) {
                                      state.didChange(value);
                                      onChanged(value);
                                    },
                                    splashRadius: 10,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        option.title,
                                        style: Theme.of(state.context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(fontWeight: FontWeight.bold), // Adiciona o tema ao componente Text
                                      ),
                                      if (option.subtitle != null)
                                        Text(
                                          option.subtitle!,
                                          style: Theme.of(state.context).textTheme.labelSmall, // Adiciona o tema ao componente Text
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 7),
                    child: Text(
                      state.errorText ?? errorMessage,
                      style: TextStyle(
                        color: Theme.of(state.context).colorScheme.error, // A cor do erro do tema atual
                        fontSize: Theme.of(state.context).textTheme.bodySmall?.fontSize, // O tamanho do texto do tema atual
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
              ],
            );
          },
        );
}
