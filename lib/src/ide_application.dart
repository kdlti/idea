import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/ide_material.dart';

class IdeAplication extends StatefulWidget {
  final List<IdeModules> modules;
  final Widget? welcome;
  final String initialRoute;
  final void Function(String route)? onRouteChanged;
  final IdeTranslation? translations;
  final Locale? locale;
  final Locale? fallbackLocale;
  final ThemeData? themeDataLight;
  final ThemeData? themeDataDark;
  final ColorScheme colorSchemeLight;
  final ColorScheme colorSchemeDark;
  final IdeBinding? binding;
  final enableLog;

  const IdeAplication({
    super.key,
    required this.modules,
    required this.initialRoute,
    this.onRouteChanged,
    this.welcome,
    this.translations,
    this.locale,
    this.fallbackLocale,
    this.themeDataLight,
    this.themeDataDark,
    this.colorSchemeLight = IdeColorScheme.light,
    this.colorSchemeDark = IdeColorScheme.dark,
    this.enableLog = false,
    this.binding,
  });

  @override
  State<IdeAplication> createState() => _IdeAplicationState();
}

class _IdeAplicationState extends State<IdeAplication> {
  late Future<GetMaterialApp> _future;

  Future<GetMaterialApp> _futureBuilder() async {
    IdeMaterial configMaterial = IdeMaterial(context, modules: widget.modules);

    ThemeData themeDataLight;
    ThemeData themeDataDark;

    if (widget.themeDataLight != null) {
      themeDataLight = widget.themeDataLight!;
    } else {
      themeDataLight = IdeTheme.create(colorScheme: widget.colorSchemeLight);
    }

    if (widget.themeDataDark != null) {
      themeDataDark = widget.themeDataDark!;
    } else {
      themeDataDark = IdeTheme.create(colorScheme: widget.colorSchemeDark);
    }

    GetMaterialApp materialApp = GetMaterialApp(
      //shortcuts: shortcuts,
      builder: (BuildContext context, Widget? child) {
        return ScrollConfiguration(key: const Key('ScrollConfiguration'), behavior: IdeScrollBehavior(), child: child!);
      },
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      defaultTransition: Transition.noTransition,
      debugShowCheckedModeBanner: false,
      getPages: configMaterial.pages,
      initialRoute: widget.initialRoute,
      routingCallback: (routing) {
        final route = routing?.current ?? '';

        // delega pro app
        widget.onRouteChanged?.call(route);
      },
      translations: await widget.translations!.messages,
      locale: widget.locale,
      fallbackLocale: widget.fallbackLocale,
      enableLog: widget.enableLog,
      themeMode: ThemeMode.light,
      theme: themeDataLight,
      darkTheme: themeDataLight,
      //navigatorObservers: [GetObserver()],
      //logWriterCallback: localLogWriter,
      unknownRoute: GetPage(name: '/pagina-nao-encontrada', page: () => const UnknownRoutePage()),
    );

    return materialApp;
  }

  @override
  void initState() {
    _future = _futureBuilder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return snapshot.data;
        }
        if (widget.welcome != null) {
          return widget.welcome!;
        }
        return const Center(child: SizedBox(width: 30, height: 30, child: IdeProgressCircular()));
      },
    );
  }
}

//TODO:: Finalizar entendimento de LOG
void localLogWriter(String text, {bool isError = false}) {
  // passage a mensagem para seu package de logging favorito aqui
  // Obs: mesmo que as mensagens de log estejam desativadas
  // com o comando "enableLog: false", as mensagens ainda vão passar por aqui
  // Você precisa checar essa config manualmente aqui se quiser respeitá-la
}

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
