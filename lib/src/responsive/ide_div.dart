import 'package:flutter/material.dart';
import 'package:idea/package.dart';

/// Use this inside `Responsive()`
///
/// This Widget requires `Finite width`
class IdeDiv extends StatelessWidget {
  final Widget child;
  final IdeDivision divison;
  final double? width;
  final double spacing;

  const IdeDiv({
    super.key,
    this.divison = const IdeDivision(),
    this.width,
    required this.child,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, box) {
        int col = 0;
        int offset = 0;
        final double width = this.width ?? MediaQuery.of(context).size.width;
        if (width < IdeResponsive.startColM) {
          col = divison.widthS;
          offset = divison.offsetS;
        } else if (width < IdeResponsive.startColL) {
          col = divison.widthM;
          offset = divison.offsetM;
        } else  {
          col = divison.widthL;
          offset = divison.offsetL;
        }

        if (col == 0) {
          return const SizedBox.shrink();
        }

        int totalGrid = 12~/col;
        final double maxWidth = box.maxWidth-((totalGrid-1)*spacing);
        final double singleBox = maxWidth / 12;
        final double childWidth = singleBox * col;
        final double childOffset = singleBox * offset;

        ///
        /// #5 fixed by @Chappie74
        ///
        final double otherWidths = (12 - col) * singleBox;

        /// Recaluclate childWidth as the calulated width souldn't be greater than box.maxWidth
        final double recalculatedChildWidth =
            (childWidth + otherWidths) > maxWidth ? childWidth - ((childWidth + otherWidths) - maxWidth) : childWidth;

        return SizedBox(
          width: recalculatedChildWidth + childOffset,
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
