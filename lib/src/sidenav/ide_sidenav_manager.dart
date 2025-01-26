import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';

class IdeSidenavManager {
  bool allowMultipleOpen = false;

  Map<String, IdeSidenavItemState> mapSidenavItemState = {};

  void addSidenavItemState(String id, IdeSidenavItemState state) {
    mapSidenavItemState[id] = state;
  }

  Map<String, IdeSidenavSubitemState> mapSidenavSubitemState = {};

  void addSidenavSubitemState(String id, IdeSidenavSubitemState state) {
    mapSidenavSubitemState[id] = state;
  }

  void reset() {
    mapSidenavItemState.clear();
    mapSidenavSubitemState.clear();
  }

  void redraw() {
    mapSidenavItemState.forEach((key, state) {
      state.redraw();
    });
    mapSidenavSubitemState.forEach((key, state) {
      state.redraw();
    });
  }

  //========================================
  // activeSelected
  //========================================
  final RxString _activeSelected = "".obs;

  set activeSelected(String uid) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _activeSelected.value = uid;
    });

    if (!allowMultipleOpen) {
      redraw();
    }
  }

  String get activeSelected => _activeSelected.value;

  String _activeOpened = "";

  set activeOpened(String uid) {
    _activeOpened = uid;
    if (!allowMultipleOpen) {
      redraw();
    }
  }

  bool isActiveOpened(String uid) {
    return _activeOpened == uid;
  }

  bool isActiveSelected(String uid) {
    return activeSelected == uid;
  }

  void select(String id) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //String uid = ApiSecurity.uidSha1(id);
      String uid = id;
      selectUid(uid);
    });
  }

  void selectUid(String uid) {
    if (mapSidenavItemState.containsKey(uid)) {
      activeSelected = uid;
      IdeSidenavItemState state = mapSidenavItemState[uid]!;
      if (state.widget.subitems != null) {
        activeOpened = uid;
        Ide.sidenavManager.activeOpened = uid;
      }
    } else if (mapSidenavSubitemState.containsKey(uid)) {
      activeSelected = uid;
      IdeSidenavSubitemState state = mapSidenavSubitemState[uid]!;
      if (state.widget.uidParent != null) {
        activeOpened = state.widget.uidParent!;
        Ide.sidenavManager.activeOpened = state.widget.uidParent!;
      }
    }
  }
}
