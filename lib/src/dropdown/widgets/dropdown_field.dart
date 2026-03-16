part of '../ide_dropdown.dart';

// overlay icon
const _defaultOverlayIconDown = Icon(
  Icons.keyboard_arrow_down_rounded,
  size: 20,
);

const _dropdownHeaderTrailingWidth = 20.0;
const _dropdownHeaderMinContentWidth = 12.0;

class _DropdownResponsiveHeaderRow extends StatelessWidget {
  final Widget child;
  final Widget trailing;
  final double preferredSpacing;

  const _DropdownResponsiveHeaderRow({
    required this.child,
    required this.trailing,
    this.preferredSpacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : _dropdownHeaderTrailingWidth +
                  _dropdownHeaderMinContentWidth +
                  preferredSpacing;
        final trailingWidth = availableWidth <= 0
            ? 0.0
            : availableWidth
                  .clamp(0.0, _dropdownHeaderTrailingWidth)
                  .toDouble();
        final remainingWidth = availableWidth - trailingWidth;
        final spacing = remainingWidth <= _dropdownHeaderMinContentWidth
            ? 0.0
            : (remainingWidth - _dropdownHeaderMinContentWidth)
                  .clamp(0.0, preferredSpacing)
                  .toDouble();

        return Row(
          children: [
            Expanded(child: child),
            if (spacing > 0) SizedBox(width: spacing),
            SizedBox(
              width: trailingWidth,
              child: Align(
                alignment: Alignment.centerRight,
                child: FittedBox(fit: BoxFit.scaleDown, child: trailing),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DropDownField<T> extends StatefulWidget {
  final VoidCallback onTap;
  final ValueNotifier<T?> selectedItemNotifier;
  final String hintText;
  final Color? fillColor;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final String? errorText;
  final TextStyle? errorStyle, headerStyle, hintStyle;
  final BorderSide? errorBorderSide;
  final Widget? suffixIcon;
  final List<BoxShadow>? shadow;
  final EdgeInsets? headerPadding;
  final int maxLines;
  final _HeaderBuilder<T>? headerBuilder;
  final _HeaderListBuilder<T>? headerListBuilder;
  final _HintBuilder? hintBuilder;
  final _DropdownType dropdownType;
  final _ValueNotifierList<T> selectedItemsNotifier;

  const _DropDownField({
    super.key,
    required this.onTap,
    required this.selectedItemNotifier,
    required this.maxLines,
    required this.dropdownType,
    required this.selectedItemsNotifier,
    this.hintText = 'Select value',
    this.fillColor,
    this.border,
    this.borderRadius,
    this.errorText,
    this.errorStyle,
    this.hintStyle,
    this.headerStyle,
    this.errorBorderSide,
    this.headerBuilder,
    this.shadow,
    this.headerListBuilder,
    this.hintBuilder,
    this.suffixIcon,
    this.headerPadding,
  });

  @override
  State<_DropDownField<T>> createState() => _DropDownFieldState<T>();
}

class _DropDownFieldState<T> extends State<_DropDownField<T>> {
  T? selectedItem;
  late List<T> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItemNotifier.value;
    selectedItems = widget.selectedItemsNotifier.value;
  }

  Widget hintBuilder(BuildContext context) {
    return widget.hintBuilder != null
        ? widget.hintBuilder!(context, widget.hintText)
        : defaultHintBuilder(widget.hintText);
  }

  Widget headerBuilder(BuildContext context) {
    return widget.headerBuilder != null
        ? widget.headerBuilder!(context, selectedItem as T)
        : defaultHeaderBuilder(oneItem: selectedItem);
  }

  Widget headerListBuilder(BuildContext context) {
    return widget.headerListBuilder != null
        ? widget.headerListBuilder!(context, selectedItems)
        : defaultHeaderBuilder(itemList: selectedItems);
  }

  Widget defaultHeaderBuilder({T? oneItem, List<T>? itemList}) {
    return Text(
      itemList != null ? itemList.join(', ') : oneItem.toString(),
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,
      style:
          widget.headerStyle ??
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  Widget defaultHintBuilder(String hint) {
    return Text(
      hint,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style:
          widget.hintStyle ??
          const TextStyle(fontSize: 16, color: Color(0xFFA7A7A7)),
    );
  }

  @override
  void didUpdateWidget(covariant _DropDownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    switch (widget.dropdownType) {
      case _DropdownType.singleSelect:
        selectedItem = widget.selectedItemNotifier.value;
      case _DropdownType.multipleSelect:
        selectedItems = widget.selectedItemsNotifier.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: widget.headerPadding ?? _defaultHeaderPadding,
        decoration: BoxDecoration(
          color: widget.fillColor ?? IdeDropdownDecoration._defaultFillColor,
          border: widget.border,
          borderRadius: widget.borderRadius ?? _defaultBorderRadius,
          boxShadow: widget.shadow,
        ),
        child: _DropdownResponsiveHeaderRow(
          trailing: widget.suffixIcon ?? _defaultOverlayIconDown,
          child: switch (widget.dropdownType) {
            _DropdownType.singleSelect =>
              selectedItem != null
                  ? headerBuilder(context)
                  : hintBuilder(context),
            _DropdownType.multipleSelect =>
              selectedItems.isNotEmpty
                  ? headerListBuilder(context)
                  : hintBuilder(context),
          },
        ),
      ),
    );
  }
}
