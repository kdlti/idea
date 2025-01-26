import 'package:idea/package.dart';
import 'package:idea/src/menubar/top/ide_menubar_top_button.dart';

class IdePanelBottomEvent {
  final String uid;
  final IdeMenubarTopButton button;
  final IdeContent content;

  IdePanelBottomEvent({
    required this.button,
    required this.content,
    required this.uid,
  });
}

