/// The scaling type.
enum ScalingType {
  /// Fixed width and height
  fixed,

  /// Fixed width, but scales to fit the screen height
  height,

  /// Fixed height, but scales to fit the screen width
  width,

  /// Scales to fit the screen width and height using the smallest scale factor
  min,

  /// Scales to fit the screen width and height using the largest scale factor
  max,
}
