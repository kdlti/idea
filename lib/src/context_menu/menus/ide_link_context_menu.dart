import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea/package.dart';

class IdeLinkContextMenu extends StatefulWidget {
  const IdeLinkContextMenu({super.key, required this.url, this.useIcons = true});
  final String url;
  final bool useIcons;

  @override
  _IdeLinkContextMenuState createState() => _IdeLinkContextMenuState();
}

class _IdeLinkContextMenuState extends State<IdeLinkContextMenu> with IdeContextMenuStateMixin {
  @override
  Widget build(BuildContext context) {
    return cardBuilder.call(
      context,
      [
        buttonBuilder.call(
          context,
          IdeContextMenuButton(
            "Open link in new window",
            icon: widget.useIcons ? const Icon(Icons.link, size: 18) : null,
            onPressed: () => handlePressed(context, _handleNewWindowPressed),
          ),
        ),
        buttonBuilder.call(
          context,
          IdeContextMenuButton(
            "Copy link address",
            icon: widget.useIcons ? const Icon(Icons.copy, size: 18) : null,
            onPressed: () => handlePressed(context, _handleClipboardPressed),
          ),
        )
      ],
    );
  }

  String _getUrl() {
    String url = widget.url;
    bool needsPrefix = !url.contains("http://") && !url.contains("https://");
    return (needsPrefix) ? "https://$url" : url;
  }

  void _handleNewWindowPressed() async {
    try {
      //TODO:: Remover launch, versão obsoleta
      //launch(_getUrl());
    } catch (e) {
      print("$e");
    }
  }

  void _handleClipboardPressed() async => Clipboard.setData(ClipboardData(text: _getUrl()));
}
