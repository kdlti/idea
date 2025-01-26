import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/panel/ide_panel_footer_style.dart';

class IdeTheme {
  static ThemeData create({required ColorScheme colorScheme}){
    return ThemeData(
      fontFamily: 'Roboto',
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.1),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 0.1),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.1),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.15),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 28, vertical: 20)),
          backgroundColor: WidgetStateProperty.all<Color>(colorScheme.primary),
          foregroundColor: WidgetStateProperty.all<Color>(colorScheme.onPrimary),
          overlayColor: WidgetStateProperty.all<Color>(colorScheme.primary.withValues(alpha:0.8)),
          //splashFactory: NoSplash.splashFactory,
          textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(fontSize: 14)),
        ),
      ),
      /*textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          foregroundColor: WidgetStateProperty.all<Color>(colorScheme.onSurfaceVariant),
          overlayColor: WidgetStateProperty.all<Color>(colorScheme.onSurfaceVariant.withValues(alpha: 0.1)),
          splashFactory: NoSplash.splashFactory,
          textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(fontSize: 12)),
        ),
      ),*/
      /*iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          foregroundColor: WidgetStateProperty.all<Color>(colorScheme.onSurfaceVariant),
          overlayColor: WidgetStateProperty.all<Color>(colorScheme.onSurfaceVariant.withValues(alpha: 0.1)),
          splashFactory: NoSplash.splashFactory,
        ),
      ),*/
      switchTheme: SwitchThemeData(
        //thumbColor: WidgetStateProperty.all<Color>(colorScheme.primary),
        thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.primary.withValues(alpha: 0.5);
          }
          if (states.contains(WidgetState.selected)) {
            return Colors.green;
          }
          return Colors.red;
        }),
        trackColor: WidgetStateProperty.all<Color>(colorScheme.surfaceVariant),
        overlayColor: WidgetStateProperty.all<Color>(colorScheme.primary.withValues(alpha: 0.1)),
        splashRadius: 16,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        trackOutlineColor: WidgetStateProperty.all<Color>(Colors.black.withValues(alpha:0.05)),
        mouseCursor: WidgetStateProperty.all<MouseCursor>(SystemMouseCursors.click),
      ),
      /*switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.primary.withValues(alpha: 0.5);
          }
          if (states.contains(WidgetState.selected)) {
            return Colors.green;
          }
          return Colors.red;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return Colors.green.shade50;
            }
            return Colors.red.shade50;
          },
        ),
        mouseCursor: WidgetStateProperty.all<MouseCursor>(SystemMouseCursors.click),
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return Colors.green.shade200;
            }
            return Colors.red.shade200;
          },
        ),
      ),*/
      /*progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        circularTrackColor: colorScheme.surfaceVariant,
        linearMinHeight: 4,
        linearTrackColor: colorScheme.surfaceVariant,
        refreshBackgroundColor: colorScheme.surfaceVariant,
      ),*/
      /*tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: TextStyle(
          fontSize: 12,
          color: colorScheme.onSurfaceVariant,
        ),
      ),*/
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true, // Habilita o preenchimento
        fillColor: Colors.white, // Define a cor de fundo
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
          ),
        ),
      ),
      // Definindo o tema global para InputDecoration
      extensions: <ThemeExtension<dynamic>>[
        IdeMenubarTopStyle(
          padding: const EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
            ),
          ),
          iconSize: 16,
          iconColor: colorScheme.onSurfaceVariant,
          iconHoverColor: colorScheme.primary,
          iconSelectedColor: colorScheme.primary,
          iconCloseSize: 35,
          iconCloseColor: Colors.white,
          iconCloseHoverColor: Colors.red,
          buttonHorizontalGap: 5,
          buttonPadding: const EdgeInsets.only(left: 8, right: 8, top: 4),
          buttonDecoration: BoxDecoration(
            color: colorScheme.surface,
            border: const Border(
              left: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              right: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
          ),
          buttonHoverDecoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            border: Border(
              left: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
              right: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
            ),
          ),
          buttonSelectedDecoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
              right: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
            ),
          ),
          indicatorHoverDecoration: BoxDecoration(
            color: colorScheme.outlineVariant,
          ),
          indicatorSelectedDecoration: BoxDecoration(
            color: colorScheme.primary,
          ),
          indicatorHeight: 3,
          text: TextStyle(
            fontSize: 13,
            color: colorScheme.onSurfaceVariant,
            height: 0,
          ),
          textHover: TextStyle(
            fontSize: 13,
            color: colorScheme.primary,
            height: 0,
          ),
          textSelected: TextStyle(
            fontSize: 13,
            color: colorScheme.primary,
            height: 0,
          ),
        ),
        IdeMenubarLeftStyle(
          iconSize: 18,
          iconColor: colorScheme.onSurfaceVariant,
          iconSelectedColor: colorScheme.primary,
          //buttonPadding: const EdgeInsets.only(top: 4, bottom: 4),
          buttonDecoration: BoxDecoration(
            color: colorScheme.surface,
            border: const Border(
              left: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              right: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
          ),
          indicatorSelectedDecoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          indicatorMargin: const EdgeInsets.only(top: 4, bottom: 4),
          indicatorWidth: 4,
        ),
        IdeMenubarBottomStyle(
          iconSize: 14,
          iconColor: colorScheme.onSurfaceVariant,
          iconHoverColor: colorScheme.primary,
          iconSelectedColor: colorScheme.primary,
          iconCloseSize: 35,
          iconCloseColor: Colors.white,
          iconCloseHoverColor: Colors.red,
          buttonHorizontalGap: 5,
          buttonPadding: const EdgeInsets.only(left: 6, right: 6, top: 3),
          buttonDecoration: BoxDecoration(
            color: colorScheme.surface,
            border: const Border(
              left: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              right: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
          ),
          buttonHoverDecoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            border: Border(
              left: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
              right: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
            ),
          ),
          buttonSelectedDecoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
              right: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
            ),
          ),
          indicatorHoverDecoration: BoxDecoration(
            color: colorScheme.outlineVariant,
          ),
          indicatorSelectedDecoration: BoxDecoration(
            color: colorScheme.primary,
          ),
          indicatorHeight: 3,
          text: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
            height: 0,
          ),
          textHover: TextStyle(
            fontSize: 12,
            color: colorScheme.primary,
            height: 0,
          ),
          textSelected: TextStyle(
            fontSize: 12,
            color: colorScheme.primary,
            height: 0,
          ),
        ),
        IdeMenubarRightStyle(
          iconSize: 18,
          iconColor: colorScheme.onSurfaceVariant,
          iconSelectedColor: colorScheme.primary,
          //buttonPadding: const EdgeInsets.only(top: 4, bottom: 4),
          buttonDecoration: BoxDecoration(
            color: colorScheme.surface,
            border: const Border(
              left: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              right: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
          ),
          indicatorSelectedDecoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
          ),
          indicatorMargin: const EdgeInsets.only(top: 4, bottom: 4),
          indicatorWidth: 4,
        ),
        IdePanelStyle(
          decoration: BoxDecoration(
            color: colorScheme.surface,
          ),
        ),
        IdePanelHeaderStyle(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.onSurface.withValues(alpha:0.12),
                width: 1,
              ),
            ),
          ),
        ),
        IdePanelFooterStyle(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            /*border: Border(
              top: BorderSide(
                color: colorScheme.onSurface.withValues(alpha:0.12),
                width: 1,
              ),
            ),*/
          ),
        ),
        const IdeTableRowStyle(
          crossAxisAlignment: CrossAxisAlignment.center,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 2),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          text: TextStyle(fontSize: 14, color: Colors.black87),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        IdeTableRowHoverStyle(
          text: const TextStyle(fontSize: 14, color: Colors.black87),
          decoration: BoxDecoration(
            color: const Color(0xFFfdb913).withValues(alpha: 0.3),
            boxShadow: const [],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
         IdeTableRowSelectedStyle(
          text: const TextStyle(fontSize: 14, color: Colors.white),
          decoration: BoxDecoration(
            color: const Color(0xFFfdb913).withValues(alpha: 0.3),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
         IdeTableRowCheckedStyle(
          text: const TextStyle(fontSize: 14, color: Colors.black87),
          decoration: BoxDecoration(
            color: colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        const IdeTableCellStyle(
          //padding: EdgeInsets.all(5),
          //margin: EdgeInsets.all(0),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          text: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const IdeTableExpandedRowStyle(
          text: TextStyle(fontSize: 14, color: Colors.red),
          margin: EdgeInsets.only(left: 4, right: 15, bottom: 0, top: 2),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            /*boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],*/
          ),
        ),
        IdeTableExpandedPanelStyle(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          margin: const EdgeInsets.only(left: 4, right: 15, bottom: 0, top: 0),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        /*IdeTableHeaderStyle(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          //margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(color: Colors.black12),
            //borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),*/
        /*const IdeTableColumnStyle(
          text: TextStyle(fontSize: 13, color: Colors.black87),
          textSelected: TextStyle(fontSize: 13, color: Colors.black),
          margin: EdgeInsets.only(left: 4, right: 4),
          padding: EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(color: Colors.black12),
            ),
          ),
        )*/
        const IdeSwitchListStyle(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          title: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          subTitle: TextStyle(fontSize: 12),
        ),
      ],
      useMaterial3: true,
    );
  }
}