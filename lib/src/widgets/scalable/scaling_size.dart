/// Scaling Factor for the [ScalableButton]
enum ScalingSize {
  /// Scalar value: 0.001
  smallest,

  /// Scalar value: 0.002
  smaller,

  /// Scalar value: 0.004
  small,

  /// Scalar value: 0.006
  medium,

  /// Scalar value: 0.008
  large,

  /// Scalar value: 0.009
  veryLarge,

  /// Scalar value: 0.01
  gigantic;

  double get scalar {
    switch (this) {
      case ScalingSize.smallest:
        return 0.001;
      case ScalingSize.smaller:
        return 0.002;
      case ScalingSize.small:
        return 0.004;
      case ScalingSize.medium:
        return 0.006;
      case ScalingSize.large:
        return 0.008;
      case ScalingSize.veryLarge:
        return 0.009;
      case ScalingSize.gigantic:
        return 0.01;
    }
  }
}
