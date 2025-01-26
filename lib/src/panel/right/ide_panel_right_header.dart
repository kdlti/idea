
import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdePanelRightHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;
  final VoidCallback? onReload;
  final String? onReloadTooltip;

  const IdePanelRightHeader({
    super.key,
    required this.title,
    this.onClose,
    this.onReload,
    this.onReloadTooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            if (onReload != null)
              IdeIconButton(
                iconData: Icons.refresh,
                onPressed: onReload,
              ),
            IdeIconButton(
              iconData: Icons.clear,
              onPressed: () {
                Ide.hidePanelRight();
                onClose?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}

