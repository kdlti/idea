import 'package:flutter/material.dart';

class IdeSearchPopupHeader extends StatelessWidget {
  final String? title;
  final bool? showCloseButton;
  final double height;

  const IdeSearchPopupHeader({
    super.key,
    this.title,
    this.showCloseButton = true,
    this.height = 17,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
            ),
          const Spacer(),
          if (showCloseButton!)
            SizedBox(
              height: 16,
              width: 16,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.clear,
                  size: 16,
                ),
              ),
            )
        ],
      ),
    );
  }
}
