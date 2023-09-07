/// Scaling Factor for the [ScalableButton]
enum ScalingSize {
  /// Scalar value: 0.0003
  smallest,

  /// Scalar value: 0.0006
  smaller,

  /// Scalar value: 0.001
  small,

  /// Scalar value: 0.003
  medium,

  /// Scalar value: 0.006
  large,

  /// Scalar value: 0.01
  veryLarge,

  /// Scalar value: 0.05
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
