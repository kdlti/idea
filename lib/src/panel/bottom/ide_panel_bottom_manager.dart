import 'package:idea/package.dart';
import 'package:idea/src/menubar/bottom/ide_menubar_bottom_button_tab.dart';

class IdePanelBottomManager {
  final Map<String, IdePanelBottom> _panelsBottom = {};
  final List<IdeMenubarBottomButtonTabState> _buttonTabs = [];
  String activeUid = '';
  String oldActiveUid = '';

  IdePanelBottom? get active {
    if (activeUid.isEmpty && Ide.activeContent!.panelBottomSelected.isEmpty) {
      return null;
    }
    if (Ide.activeContent!.panelBottomSelected.isNotEmpty && activeUid.isEmpty) {
      activeUid = Ide.activeContent!.panelBottomSelected;
    }
    Ide.panelBottom = _panelsBottom[activeUid];
    buttonTabsRedraw();
    return Ide.panelBottom;
  }

  void register(IdePanelBottom panel) {
    _panelsBottom[panel.uid] = panel;
  }

  void registerButtonTab(IdeMenubarBottomButtonTabState buttonTab) {
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
    bool hasPanel = Ide.panelBottom != null;
    IdePanelBottom? panel = active;

    if (panel == null) {
      return;
    }

    if (hasPanel && panel.visible && (oldActiveUid == uid || oldActiveUid.isEmpty)) {
      panel.visible = false;
      Ide.activeContent!.panelBottomSelected = '';
    } else if (!panel.visible) {
      panel.visible = true;
      Ide.activeContent!.panelBottomSelected = uid;
    } else {
      panel.visible = true;
      Ide.activeContent!.panelBottomSelected = uid;
    }
    oldActiveUid = uid;
    Ide.globalRedraw();
  }

  Future<void> showUid(String uid) async{
    if (_panelsBottom.containsKey(uid)) {
      activeUid = uid;
      Ide.panelBottom = active;
      Ide.panelBottom!.visible = true;
      await Ide.globalRedraw();
    }
  }

  Future<void> show(String id) async {
    //String uid = ApiSecurity.uidSha1(id);
    String uid = id;
    await showUid(uid);
  }

  void hideUid(String uid) {
    if (_panelsBottom.containsKey(uid)) {
      activeUid = uid;
      Ide.panelBottom = active;
      Ide.panelBottom!.visible = false;
      Ide.globalRedraw();
    }
  }

  void hide(String id) {
    //String uid = ApiSecurity.uidSha1(id);
    String uid = id;
    hideUid(uid);
  }
}
