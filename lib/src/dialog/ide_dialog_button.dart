import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdeDialogButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final bool selected;
  final VoidCallback onPressed;

  IdeDialogButton({super.key,
    required this.label,
    this.enabled = true,
    this.selected = false,
    required this.onPressed,
  });

  final RxBool _isHover = false.obs;

  set isHover(bool value) => _isHover.value = value;

  bool get isHover => _isHover.value;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: InkWell(
          onTap: onPressed,
          onHover: (bool value) {
            isHover = value;
          },
          child: Obx(
            () => Container(
              constraints: const BoxConstraints(minWidth: 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: isHover || (selected && enabled) ? Get.theme.primaryColor : Colors.white,
                border: Border.all(
                  color: Get.theme.primaryColor,
                ),
              ),
              height: 20,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              margin: const EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 13, letterSpacing: 0, color: isHover || (selected && enabled) ? Colors.white : Get.theme.primaryColor)),
            ),
          ),
        ),
      ),
    );
  }
}
