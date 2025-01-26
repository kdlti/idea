import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/appbar/ide_appbar_render.dart';
import 'package:idea/src/menubar/bottom/ide_menubar_bottom_render.dart';
import 'package:idea/src/menubar/left/ide_menubar_left_render.dart';
import 'package:idea/src/menubar/right/ide_menubar_right_render.dart';
import 'package:idea/src/menubar/top/ide_menubar_top_render.dart';
import 'package:idea/src/panel/bottom/ide_panel_bottom_render.dart';
import 'package:idea/src/panel/left/ide_panel_left_render.dart';
import 'package:idea/src/panel/right/ide_panel_right_render.dart';
import 'package:idea/src/statusbar/ide_statusbar_render.dart';
import 'package:idea/src/toolbar/ide_toolbar_render.dart';
import 'package:idea/src/workspace/ide_workspace_render.dart';

typedef IdeRegisterLayer = void Function();

class IdeLayer {
  Map<IdeRender, IdeRegisterLayer> _renders = {};
  List<Widget> _layers = [];

  late BuildContext context;

  IdeLayer() {
    _renders = {
      IdeRender.menubarBottom: _menubarBottom,
      IdeRender.menubarTop: _menubarTop,
      IdeRender.menubarRight: _menubarRight,
      IdeRender.panelBottom: _panelBottom,
      IdeRender.toolbar: _toolbar,
      IdeRender.panelRight: _panelRight,
      IdeRender.statusbar: _statusbar,
      IdeRender.leftMenu: _leftMenu,
      IdeRender.panelLeft: _panelLeft,
      IdeRender.appbar: _appbar,
    };
  }

  void _appbar() {
    if (Ide.appbarVisible) {
      _layers.add(const IdeAppbarRender());
    }
  }

  void _menubarBottom() {
    if (Ide.menubarBottomVisible) {
      _layers.add(const IdeMenubarBottomRender());
    }
  }

  void _panelBottom() {
    if (Ide.activeContent!.panelBottomManager.active != null) {
      Ide.panelBottom = Ide.activeContent!.panelBottomManager.active;
      Ide.panelBottom!.resize();
    }

    if (Ide.panelBottomVisible) {
      _layers.add(const IdePanelBottomRender());
    }
  }

  void _leftMenu() {
    if (Ide.menubarLeftVisible) {
      _layers.add(const IdeMenubarLeftRender());
    }
  }

  void _panelLeft() {
    if (Ide.panelLeftVisible) {
      _layers.add(const IdePanelLeftRender());
    }
  }

  void _menubarRight() {
    if (Ide.menubarRightVisible) {
      _layers.add(const IdeMenubarRightRender());
    }
  }

  void _panelRight() {
    if (Ide.activeContent!.panelRightManager.active != null) {
      Ide.panelRight = Ide.activeContent!.panelRightManager.active;
      Ide.panelRight!.resize();
    }

    if (Ide.panelRightVisible) {
      _layers.add(const IdePanelRightRender());
    }
  }

  void _statusbar() {
    if (Ide.statusbarVisible) {
      _layers.add(const IdeStatusbarRender());
    }
  }

  void _menubarTop() {
    if (Ide.menubarTopVisible) {
      _layers.add(const IdeMenubarTopRender());
    }
  }

  void _toolbar() {
    if (Ide.toolbarVisible) {
      _layers.add(const IdeToolbarRender());
    }
  }

  List<Widget> render() {
    _layers.add(const IdeWorkspaceRender());
    _renders.forEach((key, value) {
      if (_renders[key] != null) {
        _renders[key]!();
      }
    });

    if (Ide.menuOverlay != null) {
      _layers.add(Ide.menuOverlay!);
    }

    return _layers;
  }

  void reset() {
    _layers = [];
  }
}
