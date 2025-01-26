import 'package:flutter/material.dart';
import 'package:idea/package.dart';

enum IdeLayoutType { small, medium, large }

class IdeLayoutInfo {
  final double width;
  IdeLayoutType type;
  double scaleFactor = 1.0;

  IdeLayoutInfo({
    required this.width,
    this.type = IdeLayoutType.small,
  });
}

typedef IdeLayout<Widget> = Widget Function(IdeLayoutInfo info);

/// Use this inside `Responsive()`
///
/// This Widget requires `Finite width`
class IdeDivLayout extends StatelessWidget {
  final IdeLayout? childSmall;
  final IdeLayout? childMedium;
  final IdeLayout? childLarge;
  final double? width;

  const IdeDivLayout({
    super.key,
    this.width,
    this.childSmall,
    this.childMedium,
    this.childLarge,
  }): assert(childSmall != null || childMedium != null || childLarge != null, "Pelo menos um 'child' deve ser fornecido.");

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, box) {
        Widget? child;
        final double width = this.width ?? MediaQuery.of(context).size.width;

        IdeLayoutInfo layoutInfo = IdeLayoutInfo(
          width: width,
        );

        if (childSmall != null) {
          layoutInfo.type = IdeLayoutType.small;
          child = childSmall!(layoutInfo);
        }
        if (childMedium != null) {
          layoutInfo.type = IdeLayoutType.medium;
          child = childMedium!(layoutInfo);
        }
        if (childLarge != null) {
          layoutInfo.type = IdeLayoutType.large;
          child = childLarge!(layoutInfo);
        }

        if (width < IdeResponsive.startColM) {
          if (childSmall != null) {
            layoutInfo.type = IdeLayoutType.small;
            layoutInfo.scaleFactor = 0.8;
            child = childSmall!(layoutInfo);
          }
        } else if (width < IdeResponsive.startColL) {
          if (childMedium != null) {
            layoutInfo.type = IdeLayoutType.medium;
            layoutInfo.scaleFactor = 1.0;
            child = childMedium!(layoutInfo);
          }
        } else {
          if (childLarge != null) {
            layoutInfo.type = IdeLayoutType.large;
            layoutInfo.scaleFactor = 1.2;
            child = childLarge!(layoutInfo);
          }
        }

        int col = 12;
        int totalGrid = 12 ~/ col;
        final double maxWidth = box.maxWidth - (totalGrid - 1);
        final double singleBox = maxWidth / 12;
        final double childWidth = singleBox * col;

        ///
        /// #5 fixed by @Chappie74
        ///
        final double otherWidths = (12 - col) * singleBox;

        /// Recaluclate childWidth as the calulated width souldn't be greater than box.maxWidth
        final double recalculatedChildWidth =
        (childWidth + otherWidths) > maxWidth ? childWidth - ((childWidth + otherWidths) - maxWidth) : childWidth;

        return SizedBox(
          width: recalculatedChildWidth,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: recalculatedChildWidth,
                child: child,
              ),
            ],
          ),
        );
      },
    );
  }
}

