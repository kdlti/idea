import 'package:flutter/material.dart';

class IdeColorScheme{

  static const ColorScheme light = ColorScheme(
    // Define a luminosidade do tema como "light" (claro)
    brightness: Brightness.light,

    // Define a cor principal do tema
    primary: Colors.blueAccent,

    // Define a cor de componentes sobre a cor principal
    onPrimary: Color(0xFFFFFFFF),

    // Define a cor de um container com a cor principal
    //primaryContainer: Color(0xFFFAA71A),
    primaryContainer: Colors.blueAccent,

    // Define a cor de componentes sobre um container com a cor principal
    onPrimaryContainer: Color(0xFF000000),

    // Define a cor secundária do tema
    secondary: Color(0xFF00FF00),

    // Define a cor de componentes sobre a cor secundária
    onSecondary: Color(0xFFFFFFFF),

    // Define a cor de um container com a cor secundária
    //secondaryContainer: Color(0xFFFAA71A),
    secondaryContainer: Colors.blueAccent,

    // Texto e icones sobre botões
    onSecondaryContainer: Color(0xFFFFFFFF),

    // Define a cor terciária do tema
    tertiary: Color(0xFF00FF00),

    // Define a cor de componentes sobre a cor terciária
    onTertiary: Color(0xFFFFFFFF),

    // Define a cor de um container com a cor terciária
    tertiaryContainer: Color(0xFF00FF00),

    // Define a cor de componentes sobre um container com a cor terciária
    onTertiaryContainer: Color(0xFFFFFFFF),

    // Define a cor de erro
    error: Color(0xFFB92025),

    // Define a cor de um container de erro
    errorContainer: Color(0xFFFCDAD6),

    // Define a cor de componentes sobre um erro
    onError: Color(0xFFFFFFFF),

    // Define a cor de componentes sobre um container de erro
    onErrorContainer: Color(0xFF3B1213),

    // Define a cor da superfície
    // Cor utilizada em elementos de Material, como Cards e Drawers.
    surface: Color(0xFFFFFFFF),

    // Define a cor de componentes sobre a superfície
    // Cor usada para textos e ícones que estão em elementos de superfície.
    onSurface: Color(0xFF45494A),

    // Define a cor de componentes sobre a variante da superfície
    // Cor usada para textos e ícones que estão em elementos da variante de superfície.
    onSurfaceVariant: Color(0xFF5C6A71),

    // Define o tom para a superfície
    surfaceTint: Color(0xFFDCE2EA),

    // Define a cor do contorno
    // Cor usada para contornos em componentes como botões e cards.
    outline: Color(0xFFE2E7F0),

    // Define a variante de cor para o contorno
    outlineVariant: Color(0xFFE2E7F0),

    // Define a cor inversa para a cor principal
    inversePrimary: Color(0xFF00FF00),

    // Define a cor de componentes sobre a cor inversa da superfície
    onInverseSurface: Color(0xFF00FF00),

    // Define a cor inversa para a superfície
    inverseSurface: Color(0xFF00FF00),

    // Define a cor do scrim (um pano de fundo escuro usado para indicar elevação para componentes Material)
    scrim: Color(0xFF00FF00),

    // Define a cor de sombra
    shadow: Color(0xFFEBEBF1),

    onPrimaryFixed: Color(0xFF000000),
    onPrimaryFixedVariant: Color(0xFF000000),

  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.purple,
    onPrimary: Color(0xffffe1e1),
    primaryContainer: Color(0xffb8f397),
    onPrimaryContainer: Color(0xff072100),
    secondary: Color(0x99f2cb05),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffb7f397),
    onSecondaryContainer: Color(0xff072100),
    tertiary: Color(0x99f2e205),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0x4df2e205),
    onTertiaryContainer: Color(0xff002020),
    error: Color(0xfff44336),
    errorContainer: Color(0xffffdad6),
    onError: Color(0xffffffff),
    onErrorContainer: Color(0xff410002),
    surface: Color(0x1af2f2f2),
    onSurface: Color(0xff082100),
    onSurfaceVariant: Color(0xff43483e),
    outline: Color(0xff74796d),
    outlineVariant: Color(0xffc3c8bb),
    //surfaceTint: Color(0x99f28705),
    surfaceTint: Colors.blue,
    inversePrimary: Color(0xff9dd67d),
    inverseSurface: Color(0xff133800),
    onInverseSurface: Color(0xffceffae),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    onPrimaryFixed: Color(0xff000000),
  );
}