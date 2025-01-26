import 'package:get/get.dart';

class IdeMessages extends Translations {
  Map<String, Map<String, String>> locales;
  IdeMessages([this.locales = const {}]);
  @override
  Map<String, Map<String, String>> get keys => locales;
}
