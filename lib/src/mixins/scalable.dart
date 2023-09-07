import 'dart:math';
import 'dart:ui';

import '../widgets/scalable/scaling_size.dart';
import '../widgets/scalable/scaling_type.dart';

mixin Scalable {
  /// Rescale a value based on the [ScalingType] provided.
  double rescale(Size screenSize, ScalingType scalingType, double value, {ScalingSize scalingSize = ScalingSize.small, double? minClamp, double? maxClamp}) {
    assert(value >= 0, "value must be greater than or equal to 0");
    assert(minClamp == null || minClamp >= 0, "minClamp must be greater than or equal to 0");
    assert(maxClamp == null || maxClamp >= 0, "maxClamp must be greater than or equal to 0");
    assert(minClamp == null || maxClamp == null || minClamp <= maxClamp, "minClamp must be less than or equal to maxClamp");

    double scalar = scalingSize.scalar;
    double sizeFactor = 1.0;

    switch (scalingType) {
      case ScalingType.fixed:
        sizeFactor = 1.0;
        break;
      case ScalingType.height:
        sizeFactor = screenSize.height * scalar;
        break;
      case ScalingType.width:
        sizeFactor = screenSize.width * scalar;
        break;
      case ScalingType.min:
        sizeFactor = min(screenSize.width, screenSize.height) * scalar;
        break;
      case ScalingType.max:
        sizeFactor = max(screenSize.width, screenSize.height) * scalar;
        break;
    }

    // apply clamps
    if (minClamp != null && sizeFactor < minClamp) {
      print("[minClamp] adjusting sizeFactor from $sizeFactor to $minClamp");
      sizeFactor = minClamp;
    } else if (maxClamp != null && sizeFactor > maxClamp) {
      print("[maxClamp] adjusting sizeFactor from $sizeFactor to $maxClamp");
      sizeFactor = maxClamp;
    }

    return value * sizeFactor;
  }
}