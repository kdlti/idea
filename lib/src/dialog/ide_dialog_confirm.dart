import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';

import 'ide_dialog_button.dart';

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
  final bool closeRouteOnAction;
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
  IdeDialogConfirm({
    super.key,
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
    this.closeRouteOnAction = true,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportMaxHeight = MediaQuery.sizeOf(context).height * 0.8;
        final parentMaxHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : viewportMaxHeight;
        final maxDialogHeight = parentMaxHeight < viewportMaxHeight
            ? parentMaxHeight
            : viewportMaxHeight;

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
          constraints: BoxConstraints(
            minHeight: height,
            maxHeight: maxDialogHeight < height ? height : maxDialogHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              Flexible(fit: FlexFit.loose, child: buildContent()),
              buildButtons(),
            ],
          ),
        );
      },
    );
  }

  void handleAction(IdeDialogConfirmResult result, VoidCallback? callback) {
    if (closeRouteOnAction) {
      Get.back(result: result);
    }

    callback?.call();
  }

  /// Método que constrói o título do diálogo
  buildTitle() {
    return Container(
      height: 30,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 8),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Obx(
            () => Material(
              color: Colors.transparent,
              child: InkWell(
                hoverColor: Colors.red,
                onTap: () {
                  handleAction(IdeDialogConfirmResult.close, onCancel);
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

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 20, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                icon,
                size: 50,
                color: iconColor ?? Get.theme.primaryColorLight,
              ),
            ),
            const SizedBox(width: 15),
          ],
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (detail != null) ...[
                    const SizedBox(height: 5),
                    Text(detail ?? '', style: const TextStyle(fontSize: 12)),
                  ],
                  if (child != null) ...[const SizedBox(height: 10), child!],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Método que constrói os botões de ação do diálogo
  buildButtons() {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 10),
        child: Row(
          children: [
            if (allowHideMessage)
              Expanded(
                child: Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: checkBoxValue,
                        onChanged: (bool? value) {
                          checkBoxValue = value!;
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Text(
                        'Não mostrar esta mensagem novamente',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              )
            else
              const Spacer(),
            if (buttonYes)
              IdeDialogButton(
                label: 'Sim',
                selected: buttonYesSelected,
                onPressed: () {
                  handleAction(IdeDialogConfirmResult.yes, onYes);
                },
              ),
            if (buttonNo)
              IdeDialogButton(
                label: 'Não',
                selected: buttonNoSelected,
                onPressed: () {
                  handleAction(IdeDialogConfirmResult.no, onNo);
                },
              ),
            if (buttonCancel)
              IdeDialogButton(
                label: 'Cancelar',
                selected: buttonCancelSelected,
                onPressed: () {
                  handleAction(IdeDialogConfirmResult.cancel, onCancel);
                },
              ),
            if (buttonOk)
              IdeDialogButton(
                label: 'OK',
                selected: buttonOkSelected,
                onPressed: () {
                  handleAction(IdeDialogConfirmResult.ok, onOk);
                },
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
