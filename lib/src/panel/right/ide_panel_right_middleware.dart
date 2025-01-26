import 'package:idea/package.dart';

abstract class _IdePanelRightMiddleware {
  IdePanelRight? onPanelShow(IdePanelRight panel);

  IdePanelRight? onPanelHide(IdePanelRight panel);
}

/// The Panel Middlewares.
class IdePanelRightMiddleware implements _IdePanelRightMiddleware {
  @override
  IdePanelRight? onPanelShow(IdePanelRight panel) => null;

  @override
  IdePanelRight? onPanelHide(IdePanelRight panel) => null;
}
