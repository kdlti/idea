import 'package:flutter/material.dart';
import 'package:idea/src/menu/ide_menu_response.dart';

class IdeMenuEvent {
  final String title;
  bool? isChecked;
  final ValueChanged<IdeMenuResponse> onEvent;
  final String uid;

  IdeMenuEvent({
    required this.onEvent,
    required this.title,
    required this.uid,
    this.isChecked,
  });

  IdeMenuResponse response() {
    return IdeMenuResponse(
      title: title,
      uid: uid,
      isChecked: isChecked,
    );
  }
}
