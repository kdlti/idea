import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class IdeSidenavManager {
  /// Conjunto reativo de itens abertos (expandido).
  final RxSet<String> openedItems = <String>{}.obs;

  /// Item/subitem selecionado (para highlight).
  final RxString _activeSelected = ''.obs;

  String get activeSelected => _activeSelected.value;
  set activeSelected(String uid) => _activeSelected.value = uid;

  bool isActiveSelected(String uid) => _activeSelected.value == uid;
  bool isOpen(String uid) => openedItems.contains(uid);

  void toggleOpen(String uid) {
    if (openedItems.contains(uid)) {
      openedItems.remove(uid);
    } else {
      openedItems.add(uid);
    }
  }

  void open(String uid) => openedItems.add(uid);
  void close(String uid) => openedItems.remove(uid);
  void closeAll() => openedItems.clear();

  void resetUIState({bool closeMenus = false}) {
    _runAfterBuild(() {
      activeSelected = '';
      if (closeMenus) openedItems.clear();
    });
  }

  /// Seleciona um uid e, se for subitem, abre o pai.
  void selectUid(String uid, {String? parentUid}) {
    _runAfterBuild(() {
      activeSelected = uid;
      if (parentUid != null && parentUid.isNotEmpty) {
        open(parentUid);
      }
    });
  }

  void _runAfterBuild(VoidCallback fn) {
    final phase = SchedulerBinding.instance.schedulerPhase;
    final isBuilding = phase == SchedulerPhase.persistentCallbacks || phase == SchedulerPhase.midFrameMicrotasks;

    if (isBuilding) {
      WidgetsBinding.instance.addPostFrameCallback((_) => fn());
    } else {
      fn();
    }
  }
}
