import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';

import 'ide_dialog_confirm.dart';

// Enum para representar os resultados possíveis do diálogo de confirmação
enum IdeDialogConfirmResult { yes, no, cancel, ok, close }

/// Classe que define um diálogo de confirmação customizado.
///
/// `IdeDialogConfirm` é um widget que permite exibir um diálogo modal
/// com botões customizáveis, permitindo ao usuário tomar uma decisão.
/// Essa classe possui opções para exibir botões como "Sim", "Não", "Cancelar",
/// e "OK", com callbacks opcionais para cada ação.
class IdeDialogConfirm extends StatelessWidget {
  // Propriedades dos botões de ação do diálogo
  final bool buttonYes;
  final bool buttonNo;
  final bool buttonCancel;
  final bool buttonOk;
  final bool buttonYesSelected;
  final bool buttonNoSelected;
  final bool buttonCancelSelected;
  final bool buttonOkSelected;
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String message;
  final String? detail;
  final double height;
  final double width;
  final Widget? child;
  final bool allowHideMessage;
  final VoidCallback? onYes;
  final VoidCallback? onNo;
  final VoidCallback? onCancel;
  final VoidCallback? onOk;

  // Variáveis observáveis para estado do hover e valor do checkbox
  final RxBool _isHover = false.obs;
  set isHover(bool value) => _isHover.value = value;
  bool get isHover => _isHover.value;

  final RxBool _checkBoxValue = false.obs;
  set checkBoxValue(bool value) => _checkBoxValue.value = value;
  bool get checkBoxValue => _checkBoxValue.value;

  /// Construtor do diálogo de confirmação
  IdeDialogConfirm({super.key,
    this.buttonCancel = false,
    this.buttonYes = false,
    this.buttonNo = false,
    this.buttonOk = false,
    this.buttonCancelSelected = false,
    this.buttonYesSelected = false,
    this.buttonNoSelected = false,
    this.buttonOkSelected = false,
    this.height = 130,
    this.width = 470,
    this.allowHideMessage = false,
    this.child,
    this.icon,
    this.iconColor,
    required this.title,
    required this.message,
    this.detail,
    this.onYes,
    this.onNo,
    this.onCancel,
    this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      width: width,
      height: height,
      child: Stack(
        children: [
          buildTitle(), // Método para construir o título do diálogo
          IdeVisibilityBuilder(
            condition: icon != null,
            child: () => Positioned(
              left: 15,
              top: 35,
              child: Icon(
                icon,
                size: 50,
                color: iconColor ?? Get.theme.primaryColorLight,
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 40,
            right: 20,
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                IdeVisibilityBuilder(
                  condition: detail != null,
                  child: () => Text(detail ?? '', style: const TextStyle(fontSize: 12), maxLines: 3),
                ),
              ],
            ),
          ),
          buildButtons(), // Método para construir os botões do diálogo
        ],
      ),
    );
  }

  /// Método que constrói o título do diálogo
  buildTitle() {
    return Container(
      height: 30,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black87),
            ),
          ),
          const Spacer(flex: 1),
          Obx(
                () => Material(
              color: Colors.transparent,
              child: InkWell(
                hoverColor: Colors.red,
                onTap: () {
                  Get.back(result: IdeDialogConfirmResult.close);
                  if (onCancel != null) {
                    onCancel!();
                  }
                },
                onHover: (bool value) {
                  isHover = value;
                },
                child: Tooltip(
                  message: 'Fechar',
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(
                      Icons.clear_rounded,
                      color: isHover ? Colors.white : Colors.redAccent,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Método que constrói os botões de ação do diálogo
  buildButtons() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 50,
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IdeVisibilityBuilder(
              condition: allowHideMessage,
              child: () => Obx(
                    () => Checkbox(
                    value: checkBoxValue,
                    onChanged: (bool? value) {
                      checkBoxValue = value!;
                    }),
              ),
            ),
            IdeVisibilityBuilder(
              condition: allowHideMessage,
              child: () => const Text(
                'Não mostrar esta mensagem novamente',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const Spacer(),
            IdeVisibilityBuilder(
              condition: buttonYes,
              child: () => IdeDialogButton(
                  label: 'Sim',
                  selected: buttonYesSelected,
                  onPressed: () {
                    Get.back(result: IdeDialogConfirmResult.yes);
                    if (onYes != null) {
                      onYes!();
                    }
                  }),
            ),
            IdeVisibilityBuilder(
              condition: buttonNo,
              child: () => IdeDialogButton(
                  label: 'Não',
                  selected: buttonNoSelected,
                  onPressed: () {
                    Get.back(result: IdeDialogConfirmResult.no);
                    if (onNo != null) {
                      onNo!();
                    }
                  }),
            ),
            IdeVisibilityBuilder(
              condition: buttonCancel,
              child: () => IdeDialogButton(
                  label: 'Cancelar',
                  selected: buttonCancelSelected,
                  onPressed: () {
                    Get.back(result: IdeDialogConfirmResult.cancel);
                    if (onCancel != null) {
                      onCancel!();
                    }
                  }),
            ),
            IdeVisibilityBuilder(
              condition: buttonOk,
              child: () => IdeDialogButton(
                  label: 'OK',
                  selected: buttonOkSelected,
                  onPressed: () {
                    Get.back(result: IdeDialogConfirmResult.ok);
                    if (onOk != null) {
                      onOk!();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  /// Método estático para exibir o diálogo e capturar o resultado
  ///
  /// Este método permite que o diálogo seja mostrado e retorna um resultado
  /// dependendo do botão que o usuário clicou (Sim, Não, Cancelar, OK).
  ///
  /// Exemplo de uso do `IdeDialogConfirm` no seu código:
  ///
  /// ```dart
  /// void showConfirmationDialog(BuildContext context) async {
  ///   IdeDialogConfirmResult? result = await IdeDialogConfirm.show(
  ///     context: context,
  ///     title: 'Confirmação',
  ///     message: 'Você tem certeza que deseja continuar?',
  ///     buttonYes: true,
  ///     buttonNo: true,
  ///     buttonCancel: true,
  ///     onYes: () {
  ///       // Você pode fazer algo aqui ao clicar em "Sim"
  ///       print('Usuário clicou em Sim');
  ///     },
  ///     onNo: () {
  ///       // Você pode fazer algo aqui ao clicar em "Não"
  ///       print('Usuário clicou em Não');
  ///     },
  ///     onCancel: () {
  ///       // Você pode fazer algo aqui ao clicar em "Cancelar"
  ///       print('Usuário clicou em Cancelar');
  ///     },
  ///   );
  ///
  ///   // Captura do evento de callback diretamente pelo resultado
  ///   switch (result) {
  ///     case IdeDialogConfirmResult.yes:
  ///       print('Resultado: Usuário confirmou Sim');
  ///       break;
  ///     case IdeDialogConfirmResult.no:
  ///       print('Resultado: Usuário escolheu Não');
  ///       break;
  ///     case IdeDialogConfirmResult.cancel:
  ///       print('Resultado: Usuário cancelou');
  ///       break;
  ///     default:
  ///       print('Diálogo fechado sem resposta');
  ///   }
  /// }
  /// ```
  ///
  /// Este exemplo mostra como exibir o diálogo e tratar as respostas possíveis
  /// do usuário, como "Sim", "Não" e "Cancelar".
  ///
  static Future<IdeDialogConfirmResult?> show({
    required BuildContext context,
    required String title,
    required String message,
    String? detail,
    IconData? icon,
    Color? iconColor,
    bool buttonYes = false,
    bool buttonNo = false,
    bool buttonCancel = false,
    bool buttonOk = false,
    bool buttonYesSelected = false,
    bool buttonNoSelected = false,
    bool buttonCancelSelected = false,
    bool buttonOkSelected = false,
    double height = 130,
    double width = 470,
    bool allowHideMessage = false,
    Widget? child,
    VoidCallback? onYes,
    VoidCallback? onNo,
    VoidCallback? onCancel,
    VoidCallback? onOk,
  }) async {
    return await showDialog<IdeDialogConfirmResult>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: IdeDialogConfirm(
            title: title,
            message: message,
            detail: detail,
            icon: icon,
            iconColor: iconColor,
            buttonYes: buttonYes,
            buttonNo: buttonNo,
            buttonCancel: buttonCancel,
            buttonOk: buttonOk,
            buttonYesSelected: buttonYesSelected,
            buttonNoSelected: buttonNoSelected,
            buttonCancelSelected: buttonCancelSelected,
            buttonOkSelected: buttonOkSelected,
            height: height,
            width: width,
            allowHideMessage: allowHideMessage,
            child: child,
            onYes: onYes,
            onNo: onNo,
            onCancel: onCancel,
            onOk: onOk,
          ),
        );
      },
    );
  }
}
