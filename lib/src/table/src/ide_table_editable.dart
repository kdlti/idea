import 'package:flutter/material.dart';
import 'package:idea/package.dart';

/// `IdeTableEditable`
///
/// use to display when user allow any header columns to be editable
class IdeTableEditable extends StatelessWidget {
  /// `data`
  ///
  /// current data as Map
  final Map<String, dynamic> data;

  /// `header`
  ///
  /// current editable text header
  final IdeTableColumn header;

  /// `textAlign`
  ///
  /// by default textAlign will be center
  final TextAlign textAlign;

  /// `onChanged`
  ///
  /// trigger the call back update when user make any text change
  final Function(Map<String, dynamic> vaue, IdeTableColumn header)? onChanged;

  /// `onSubmitted`
  ///
  /// trigger the call back when user press done or enter
  final Function(Map<String, dynamic> vaue, IdeTableColumn header)? onSubmitted;

  final VoidCallback onEditingComplete;

  const IdeTableEditable({
    super.key,
    required this.data,
    required this.header,
    this.textAlign = TextAlign.center,
    this.onChanged,
    this.onSubmitted,
    required this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      constraints: const BoxConstraints(maxWidth: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        style: const TextStyle(fontSize: 14),
        maxLines: 2,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 5, right: 0, top: 0, bottom:0),
          border: InputBorder.none,
          alignLabelWithHint: true,
          suffixIcon: InkWell(
            onTap: () {
              onSubmitted?.call(data, header);
              onEditingComplete();
            },
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: const Icon(Icons.check_rounded, size: 16, color: Colors.green),
          ),
        ),
        textAlign: textAlign,
        controller: TextEditingController.fromValue(
          TextEditingValue(text: "${data[header.value]}"),
        ),
        onChanged: (newValue) {
          data[header.value] = newValue;
          onChanged?.call(data, header);
        },
        onSubmitted: (x) => onSubmitted?.call(data, header),
      ),
    );
  }
}