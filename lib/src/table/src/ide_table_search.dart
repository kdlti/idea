import 'package:flutter/material.dart';

class IdeTableSearch {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool visible;

  late BoxDecoration? decoration;

  IdeTableSearch({
    this.decoration,
    this.visible = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
    this.margin = const EdgeInsets.only(bottom: 4),
  }) {
    decoration = decoration ??
        BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          //borderRadius: const BorderRadius.all(Radius.circular(25)),
          /*borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),*/
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        );
  }
}
