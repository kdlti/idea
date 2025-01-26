class IdeSize {
  double minWidth;
  double minHeight;
  double maxWidth;
  double maxHeight;
  double width;
  double height;
  double devicePixelRatio;

  IdeSize({
    this.width = 0,
    this.height = 0,
    this.minWidth = 0,
    this.maxWidth = 0,
    this.maxHeight = 0,
    this.minHeight = 0,
    this.devicePixelRatio = 1,
  });

  IdeSize copyWith({double? width, double? height, double? minWidth, double? maxWidth, double? minHeight, double? maxHeight}) {
    return IdeSize(
      width: width ?? this.width,
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
    );
  }

  @override
  String toString() {
    return '(width:$width, height:$height, minWidth:$minWidth, maxWidth:$maxWidth, minHeight:$minHeight, maxHeight:$maxHeight)';
  }
}
