import 'package:idea/package.dart';
import 'package:idea/src/menubar/right/ide_menubar_right_button_tab.dart';

class IdePanelRightManager {
  final Map<String, IdePanelRight> _panelsRight = {};
  final List<IdeMenubarRightButtonTabState> _buttonTabs = [];
  String activeUid = '';
  String oldActiveUid = '';
  String activeId = '';

  IdePanelRight? get active {
    if (Ide.activeContent!.panelRightSelected.isNotEmpty && activeUid.isEmpty) {
      activeUid = Ide.activeContent!.panelRightSelected;
    }

    Ide.panelRight = _panelsRight[activeUid];
    buttonTabsRedraw();
    return Ide.panelRight;
  }

  void register(IdePanelRight panel) {
    _panelsRight[panel.uid] = panel;
  }

  void registerButtonTab(IdeMenubarRightButtonTabState buttonTab) {
    _buttonTabs.add(buttonTab);
  }

  void buttonTabsRedraw() {
    for (var element in _buttonTabs) {
      element.redraw();
    }
  }

  void toggle(String uid) {
    if (uid.isEmpty) {
      return;
    }

    activeUid = uid;
    bool hasPanel = Ide.panelRight != null;
    IdePanelRight? panel = active;

    if (panel == null) {
      return;
    }

    if (hasPanel && panel.visible && (oldActiveUid == uid || oldActiveUid.isEmpty)) {
      panel.visible = false;
      Ide.activeContent!.panelRightSelected = '';
    } else if (!panel.visible) {
      panel.visible = true;
      Ide.activeContent!.panelRightSelected = uid;
    } else {
      panel.visible = true;
      Ide.activeContent!.panelRightSelected = uid;
    }
    oldActiveUid = uid;
    Ide.globalRedraw();
  }

  void showUid(String uid, {required bool redraw, required String state}) {
    if (_panelsRight.containsKey(uid)) {
      activeUid = uid;
      Ide.panelRight = active;
      Ide.panelRight!.visible = true;
      Ide.sidenavManager.selectUid(uid);

      if(redraw) {
        Ide.state.redraw(state, force: true);
      }
      Ide.globalRedraw();
    }
  }

  void show(String id, {required bool redraw}) {
    activeId = id;
    Ide.activeContent!.panelRightSelected = id;
    showUid(Ide.activeContent!.panelRightSelected, redraw: redraw, state: "${id}State");
  }

  void hideUid(String uid) {
    if (_panelsRight.containsKey(uid)) {
      activeUid = uid;
      Ide.panelRight = active;
      Ide.panelRight!.visible = false;
      middlewaresOnPanelHide();
      Ide.globalRedraw();
    }
  }

  void hide(String id) {
    hideUid(id);
  }

  void middlewaresOnPanelShow() {
    if (Ide.panelRight!.middlewares != null) {
      for (var middleware in Ide.panelRight!.middlewares!) {
        middleware.onPanelShow(Ide.panelRight!);
      }
    }
  }

  void middlewaresOnPanelHide() {
    if (Ide.panelRight!.middlewares != null) {
      for (var middleware in Ide.panelRight!.middlewares!) {
        middleware.onPanelHide(Ide.panelRight!);
      }
    }
  }
}

