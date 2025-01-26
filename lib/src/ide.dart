import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/ide_state.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';
import 'package:idea/src/sidenav/ide_sidenav_manager.dart';
import 'package:idea/src/workspace/ide_workspace_manager.dart';
import 'package:logger/logger.dart';

import 'ide_register.dart';

typedef IdeFunction<Widget> = Widget Function();
typedef OnNext = void Function();

class Ide {
  /// Método utilitário para logar mensagens de erro.
  static get logError => Logger(
        printer: PrettyPrinter(),
      ).e;

  /// Método utilitário para logar mensagens de informação.
  static get logInfo => Logger(
        printer: PrettyPrinter(),
      ).i;

  /// Método utilitário para logar mensagens de depuração.
  static get logDebug => Logger(
        printer: PrettyPrinter(),
      ).d;

  /// Método utilitário para logar mensagens de aviso.
  static get logWarning => Logger(
        printer: PrettyPrinter(),
      ).w;

  static bool _mounted = false;

  static bool get mounted => _mounted && state.mounted;

  static set mounted(bool value) {
    _mounted = value;
  }

  Ide._privateConstructor();

  static final Ide _instance = Ide._privateConstructor();

  factory Ide() {
    return _instance;
  }

  static late void Function(VoidCallback fn) setState;
  static void Function() setStateExecute = () {
    setState(() {});
  };

  static dynamic tableRowDataSelected;

  static IdeAppbar? get appbar => activeContent?.appbar;

  static IdeStatusbar? get statusbar => activeContent?.statusbar;

  static IdeToolbar? get toolbar => activeContent?.toolbar;

  static IdeMenubarLeft? get menubarLeft => activeContent?.menubarLeft;

  static IdeMenubarRight? get menubarRight => activeContent?.menubarRight;

  static IdePanelLeft? get panelLeft => activeContent?.panelLeft;

  static IdeMenubarBottom? get menubarBottom => activeContent?.menubarBottom;

  static IdeRegister get register => IdeRegister();

  static IdeMenubarTop? menubarTop;
  static IdeLayer? layer;
  static IdePanelRight? panelRight;
  static IdePanelBottom? panelBottom;
  static IdeMenuOverlay? menuOverlay = const IdeMenuOverlay();

  /// Finds a Instance of the required Class `<S>`(or [tag])
  /// In the case of using `Get.create()`, it will generate an Instance
  /// each time you call `Edi.controller()`.
  static S controller<S>({String? tag}) => GetInstance().find<S>(tag: tag);

  static void binding<S>(InstanceBuilderCallback<S> builder, {String? tag, bool fenix = false}) {
    GetInstance().lazyPut<S>(builder, tag: tag, fenix: fenix);
    //GetInstance().put<S>(builder(), tag: tag, permanent: true);
  }

  static void globalBinding<S>(InstanceBuilderCallback<S> builder, {String? tag, bool fenix = false}) {
    GetInstance().put<S>(builder(), tag: tag, permanent: true);
  }

  //TODO: Implementar o IdeGlobal
  static bool mapLoaded = false;

  //========================================
  // inProgress
  //========================================
  //TODO: Remover essa implementação, ela gera erro de tempo de execução em alguns casos
  static final RxBool _inProgress = false.obs;

  static RxBool get progress => _inProgress;

  static set inProgress(bool value) => _inProgress.value = value;

  static bool get inProgress => _inProgress.value;

  static void loading(bool status) {
    if (hasStatusbar && mounted) {
      state.find("IdeStatusbarProgressState")?.updateProgress(status);
    }
  }

  //========================================
  // active
  //========================================
  static String activeContentUid = '';
  static IdeContent? activeContent;
  static String activeRoute = '';

  //========================================
  // hover
  //========================================
  static String hoverBottomTabUid = '';
  static String hoverMenubarTopUid = '';
  static String hoverLeftMenuButtonUid = '';

  //================================================================================
  //
  // public properties
  //
  //================================================================================

  static IdeState state = IdeState();
  static dynamic boxPreferences;

  static String selectedMenuUid = '';

  //========================================
  // activeId
  //========================================
  static final RxString _activeId = "".obs;

  static set activeId(String value) => _activeId.value = value;

  static String get activeId => _activeId.value;

  static IdeSidenavManager sidenavManager = IdeSidenavManager();

  static IdeWorkspaceManager? workspaceManager;

  static FocusNode focusNode = FocusNode();

  static bool get hasAppbar {
    return appbar != null;
  }

  static bool get hasPanelRight {
    return panelRight != null;
  }

  static bool get hasMenubarRight {
    return menubarRight != null;
  }

  static bool get hasMenubarLeft {
    return menubarLeft != null;
  }

  static bool get hasPanelLeft {
    return panelLeft != null;
  }

  static bool get hasStatusbar {
    return statusbar != null;
  }

  static bool get hasPanelBottom {
    return panelBottom != null;
  }

  static bool get hasMenubarBottom {
    return menubarBottom != null;
  }

  static bool get hasMenubarTop {
    return menubarTop != null;
  }

  static bool get hasProgress {
    return false;
  }

  static bool get hasToolbar {
    return toolbar != null;
  }

  //================================================================================
  // visible
  //================================================================================
  static bool get appbarVisible {
    return appbar != null && appbar!.visible;
  }

  static bool get panelRightVisible {
    return panelRight != null && panelRight!.visible;
  }

  static bool get menubarRightVisible {
    return menubarRight != null && menubarRight!.visible;
  }

  static bool get menubarLeftVisible {
    return menubarLeft != null && menubarLeft!.visible;
  }

  static bool get panelLeftVisible {
    return panelLeft != null && panelLeft!.visible;
  }

  static bool get statusbarVisible {
    return statusbar != null && statusbar!.visible;
  }

  static bool get panelBottomVisible {
    return panelBottom != null && panelBottom!.visible;
  }

  static bool get menubarBottomVisible {
    return menubarBottom != null && menubarBottom!.visible;
  }

  static bool get menubarTopVisible {
    return menubarTop != null && menubarTop!.visible;
  }

  static bool get toolbarVisible {
    return toolbar != null && toolbar!.visible;
  }

  static void initState(String name, dynamic state) {
    Ide.state.add(name, state);
  }

  static void disposeState<T>() {
    if (T != dynamic) {
      Ide.state.disposeState<T>();
    } else {
      String errorMessage = """
════════ Exception caught by Ide.disposeState<T>() ════════
Você precisa indicar o tipo de state para remover a classe utilizando 'Ide.disposeState<?>(this)'""";
      ideLog.e(errorMessage, error: {"Ide.disposeState<?>(this)": state}, stackTrace: StackTrace.current);
      throw errorMessage;
    }
  }

  //================================================================================
  // hide
  //================================================================================
  static void hideAll() {
    if (hasToolbar) {
      toolbar!.visible = false;
    }
    if (hasPanelRight) {
      panelRight!.visible = false;
    }
    if (hasMenubarRight) {
      menubarRight!.visible = false;
    }
    if (hasMenubarLeft) {
      menubarLeft!.visible = false;
    }
    if (hasPanelLeft) {
      panelLeft!.visible = false;
    }
    if (hasStatusbar) {
      statusbar!.visible = false;
    }
    if (hasMenubarTop) {
      menubarTop!.visible = false;
    }
    if (hasPanelBottom) {
      panelBottom!.visible = false;
    }
    if (hasAppbar) {
      appbar!.visible = false;
    }
    if (hasMenubarBottom) {
      menubarBottom!.visible = false;
    }
    globalRedraw();
  }

  static void hidePanelRight() {
    if (hasPanelRight) {
      panelRight!.visible = false;
      activeContent!.panelRightManager.hide(panelRight!.id);

      globalRedraw();
    }
  }

  static void hIdeMenubarRight() {
    if (hasMenubarRight) {
      menubarRight!.visible = false;
      globalRedraw();
    }
  }

  static void hideLeftMenu() {
    if (hasMenubarLeft) {
      menubarLeft!.visible = false;
      globalRedraw();
    }
  }

  static void panelLeftHide() {
    if (hasPanelLeft) {
      panelLeft!.visible = false;
      globalRedraw();
    }
  }

  static void hideMenubarBottom() {
    if (hasMenubarBottom) {
      menubarBottom!.visible = false;
      globalRedraw();
    }
  }

  static void hideStatusbar() {
    if (hasStatusbar) {
      statusbar!.visible = false;
      globalRedraw();
    }
  }

  static void panelBottomHide() {
    if (hasPanelBottom) {
      panelBottom!.visible = false;
      globalRedraw();
    }
  }

  static void hideAppbar() {
    if (hasAppbar) {
      appbar!.visible = false;
      globalRedraw();
    }
  }

  static void hideToolbar() {
    if (hasToolbar) {
      toolbar!.visible = false;
      globalRedraw();
    }
  }

  static void menubarTopHide() {
    if (hasMenubarTop) {
      menubarTop!.visible = false;
      globalRedraw();
    }
  }

  //================================================================================
  // show
  //================================================================================
  static void showAll() {
    if (hasPanelRight) {
      panelRight!.visible = true;
    }
    if (hasMenubarRight) {
      menubarRight!.visible = true;
    }
    if (hasMenubarLeft) {
      menubarLeft!.visible = true;
    }
    if (hasPanelLeft) {
      panelLeft!.visible = true;
    }
    if (hasMenubarBottom) {
      menubarBottom!.visible = true;
    }
    if (hasStatusbar) {
      statusbar!.visible = true;
    }
    if (hasPanelBottom) {
      panelBottom!.visible = true;
    }
    if (hasAppbar) {
      appbar!.visible = true;
    }
    if (hasToolbar) {
      toolbar!.visible = true;
    }
    if (hasMenubarTop) {
      menubarTop!.visible = true;
    }
    globalRedraw();
  }

  static void showContent(String id) {
    if (activeContent!.id == id) {
      return;
    }

    workspaceManager!.showContent(id);
  }

  static void showContentTab({required String id, required String uid, String? label}) {
    workspaceManager!.showContentTab(id: id, uid: uid, label: label);
  }

  static Future<void> showPanelRight(String id, {bool redraw = true}) async {
    if (hasPanelRight) {
      activeContent!.panelRightManager.show(id, redraw: redraw);
      if (activeContent!.panelsRight?.onShow != null) {
        activeContent!.panelsRight!.onShow!(id);
      }
    }
  }

  static void menubarRightShow() {
    if (hasMenubarRight) {
      menubarRight!.visible = true;
      globalRedraw();
    }
  }

  static void menubarLeftShow() {
    if (hasMenubarLeft) {
      menubarLeft!.visible = true;
      globalRedraw();
    }
  }

  static void menubarLeftHide() {
    if (hasMenubarLeft) {
      menubarLeft!.visible = false;
      globalRedraw();
    }
  }

  static void panelLeftShow() {
    if (hasPanelLeft) {
      panelLeft!.visible = true;
      globalRedraw();
    }
  }

  static void menubarBottomShow() {
    if (hasMenubarBottom) {
      menubarBottom!.visible = true;
      globalRedraw();
    }
  }

  static void statusbarShow() {
    if (hasStatusbar) {
      statusbar!.visible = true;
      globalRedraw();
    }
  }

  static void statusbarHide() {
    if (hasStatusbar) {
      statusbar!.visible = false;
      globalRedraw();
    }
  }

  static Future<void> panelBottomShow(String id, {OnNext? onNext}) async {
    if (hasPanelBottom) {
      await activeContent!.panelBottomManager.show(id);
      if (onNext != null) {
        Future.delayed(const Duration(milliseconds: 10), () {
          onNext();
        });
      }
    }
  }

  static void appbarShow() {
    if (hasAppbar) {
      appbar!.visible = true;
      globalRedraw();
    }
  }

  static void appbarHide() {
    if (hasAppbar) {
      appbar!.visible = false;
      globalRedraw();
    }
  }

  static void toolbarShow() {
    if (hasToolbar) {
      toolbar!.visible = true;
      globalRedraw();
    }
  }

  static void toolbarHide() {
    if (hasToolbar) {
      toolbar!.visible = false;
      globalRedraw();
    }
  }

  static void menubarTopShow() {
    if (hasMenubarTop) {
      menubarTop!.visible = true;
      globalRedraw();
    }
  }

  static Future<void> toRoute(String path) async {
    if (activeRoute == path) {
      return;
    }
    mounted = false;
    await Get.offNamed(path);
  }

  //================================================================================
  // toggle
  //================================================================================
  static void panelRightToggle(String uid) {
    activeContent!.panelRightManager.toggle(uid);
  }

  static void panelLeftToggle() {
    if (hasPanelLeft) {
      panelLeft!.visible = !panelLeft!.visible;
      globalRedraw();
    }
  }

  static void menubarBottomToggle() {
    if (hasMenubarBottom) {
      menubarBottom!.visible = !menubarBottom!.visible;
      globalRedraw();
    }
  }

  static void statusbarToggle() {
    if (hasStatusbar) {
      statusbar!.visible = !statusbar!.visible;
      globalRedraw();
    }
  }

  static void panelBottomToggle(String uid) {
    activeContent!.panelBottomManager.toggle(uid);
  }

  static void appbarToggle() {
    if (hasAppbar) {
      appbar!.visible = !appbar!.visible;
      globalRedraw();
    }
  }

  static void toolbarToggle() {
    if (hasToolbar) {
      toolbar!.visible = !toolbar!.visible;
      globalRedraw();
    }
  }

  static void menubarTopToggle() {
    if (hasMenubarTop) {
      menubarTop!.visible = !menubarTop!.visible;
      globalRedraw();
    }
  }

  static Future<void> globalRedraw() async {
    if (!mounted) {
      return;
    }

    if (hasAppbar) {
      appbar!.resize();
    }
    if (hasToolbar) {
      toolbar!.resize();
    }
    if (hasStatusbar) {
      statusbar!.resize();
    }
    if (hasMenubarLeft) {
      menubarLeft!.resize();
    }
    if (hasPanelLeft) {
      panelLeft!.resize();
    }
    if (hasMenubarRight) {
      menubarRight!.resize();
    }
    if (hasPanelRight) {
      panelRight!.resize();
    }
    if (hasMenubarBottom) {
      menubarBottom!.resize();
    }
    if (hasPanelBottom) {
      panelBottom!.resize();
    }
    if (hasMenubarTop) {
      menubarTop!.resize();
    }
    state.redraw("IdeModuleRender");
    state.redraw("IdeWorkspaceRender", force: true);
    state.redraw("IdeProgressRender", force: true);
    state.redraw("IdeAppbarRender", force: true);
    state.redraw("IdeMenubarRender", force: true);
    state.redraw("IdeMenubarBottomRender", force: true);
    state.redraw("IdePanelBottomRender", force: true);
    state.redraw("IdeMenubarLeftRender", force: true);
    state.redraw("IdePanelLeftRender", force: true);
    state.redraw("IdeMenubarRightRender", force: true);
    state.redraw("IdePanelRightRender", force: true);
    state.redraw("IdeMenubarTopRender", force: true);
    state.redraw("IdeToolbarRender", force: true);
    state.redraw("IdeToolbarRender", force: true);
  }

  //================================================================================
  //
  // IdeDialog
  //
  //================================================================================
  static Future<S?> dialog<S>(widget) async {
    return await Get.dialog<S>(
      widget,
      barrierColor: Colors.black87.withValues(alpha: 0.3),
      barrierDismissible: false,
    );
  }

  //================================================================================
  //
  // private methods
  //
  //================================================================================
  static void dispose() {
    mounted = false;
    focusNode.dispose();
    workspaceManager!.dispose();
    state.dispose();
    panelRight = null;
  }
}
