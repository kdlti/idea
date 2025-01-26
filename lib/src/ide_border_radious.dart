class IdeBorderRadious {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;

  const IdeBorderRadious({
    this.topLeft = 0.0,
    this.topRight = 0.0,
    this.bottomLeft = 0.0,
    this.bottomRight = 0.0,
  });

  const IdeBorderRadious.all(double radius)
      : topLeft = radius,
        topRight = radius,
        bottomLeft = radius,
        bottomRight = radius;
}