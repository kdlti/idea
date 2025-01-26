import 'package:flutter/material.dart';
import 'package:idea/src/widget/radio_list/package.dart';

class IdeRadioRow extends FormField<String> {
  final List<IdeRadioListOption> options;
  @override
  final String? initialValue;
  final String? Function(String?) validator;
  final String errorMessage;
  final void Function(String?) onChanged; // Adicione esta linha

  IdeRadioRow({
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
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...options.map((option) {
                  return SizedBox(
                    width: 90,
                    child: IgnorePointer(
                      ignoring: option.enabled == false,
                      child: Opacity(
                        opacity: option.enabled == false ? 0.5 : 1,
                        child: InkWell(
                          onTap: () {
                            state.didChange(option.value);
                            validator(option.value);
                            onChanged(option.value);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //mainAxisSize: MainAxisSize.min,
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
                              if(option.subtitle!=null)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      option.title,
                                      style: Theme.of(state.context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontWeight: FontWeight.bold), // Adiciona o tema ao componente Text
                                    ),
                                    Text(
                                      option.subtitle!,
                                      style: Theme.of(state.context).textTheme.labelSmall, // Adiciona o tema ao componente Text
                                    ),
                                  ],
                                ),
                              ),
                              if(option.subtitle==null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  option.title,
                                  style: Theme.of(state.context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(fontWeight: FontWeight.bold), // Adiciona o tema ao componente Text
                                ),
                              ),
                            ],
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
