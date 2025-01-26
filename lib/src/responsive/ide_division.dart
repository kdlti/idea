/// Set col and offset
class IdeDivision {
  /// Small screen `375.0 to 596.0`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width ~ replaced with SizedBox.shrink()
  ///
  /// `12` ~ full width
  ///
  /// `null` / `default` ~ takes [small] value
  final int? small;

  /// Medium screen `596.0 to 897.0`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width ~ replaced with SizedBox.shrink()
  ///
  /// `12` ~ full width
  ///
  /// `null` / `default` ~ takes [small] value
  final int? medium;

  /// Large screen `897.0 to 1232.0`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width / gone
  ///
  /// `12` ~ full width
  ///
  /// `null` / `default` ~  takes [medium] value
  final int? large;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetS;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetM;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetL;

  const IdeDivision({
    this.small = 12,
    this.medium,
    this.large,
    this.offsetS = 0,
    this.offsetM = 0,
    this.offsetL = 0,
  })  : assert(small == null || (small >= 0 && small <= 12)),
        assert(medium == null || (medium >= 0 && medium <= 12)),
        assert(large == null || (large >= 0 && large <= 12)),
        assert(offsetS >= 0 && offsetS <= 11),
        assert(offsetM >= 0 && offsetM <= 11),
        assert(offsetL >= 0 && offsetL <= 11),
        assert(medium == null || (medium + offsetM <= 12),
            "sum of the medium and the respective offsetM should be less than or equal to 12"),
        assert(large == null || (large + offsetL <= 12),
            "sum of the large and the respective offsetL should be less than or equal to 12");

  /// Returns the width of the column for the given screen size
  ///
  /// internal use only
  int get widthS => small!;

  /// Returns the width of the column for the given screen size
  ///
  /// internal use only
  int get widthM => medium ?? widthS;

  /// Returns the width of the column for the given screen size
  ///
  /// internal use only
  int get widthL => large ?? widthM;

  // copy with method
  IdeDivision copyWith({
    int? small,
    int? medium,
    int? large,
    int? offsetS,
    int? offsetM,
    int? offsetL,
  }) {
    return IdeDivision(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      offsetS: offsetS ?? this.offsetS,
      offsetM: offsetM ?? this.offsetM,
      offsetL: offsetL ?? this.offsetL,
    );
  }
}
