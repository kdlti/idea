import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/src/dialog/ide_dialog_callback.dart';

class IdeDialog extends StatelessWidget {
  final String buttonCancel;
  final String buttonConfirm;
  final BoxConstraints constraints;
  final IconData icon;
  final String title;
  final double height;
  final double width;
  final VoidCallback onCancel;
  final ValueChanged<IdeDialogCallback> onConfirm;

  const IdeDialog({super.key,
    required this.buttonCancel,
    required this.buttonConfirm,
    required this.constraints,
    required this.icon,
    required this.title,
    this.height = 350,
    this.width = 600,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white10,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border.all(
              color: Colors.blueAccent,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withValues(alpha: 0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          width: width,
          height: height,
          child: Stack(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.blueAccent),
                  ),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Título da popup',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: 'Optima'),
                      ),
                    ),
                    const Spacer(flex: 1),
                    InkWell(
                      onTap: () {
                        Get.back(result: 'Result');
                      },
                      child: const Tooltip(
                        message: 'Fechar popup',
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.clear_rounded,
                            color: Colors.blueAccent,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 50,
                top: 30,
                child: Container(
                    //color: Colors.red.withValues(alpha: 0.3),
                    ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 50,
                child: Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        //textColor: Colors.redAccent,
                        //disabledColor: Colors.grey,
                        //disabledTextColor: Colors.black,
                        //hoverColor: Colors.redAccent.withValues(alpha: 0.1),
                        onPressed: () {
                          Get.back(result: false);
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 10
                      ),
                      TextButton(
                        //hoverColor: Colors.green.withValues(alpha: 0.3),
                        //textColor: Colors.green,
                        //disabledColor: Colors.grey,
                        //disabledTextColor: Colors.black,
                        onPressed: () {
                          Get.back(result: true);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Salvar",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
