import 'dart:math';
import 'dart:ui';

import '../widgets/scalable/scaling_size.dart';
import '../widgets/scalable/scaling_type.dart';

mixin Scalable {
  /// Rescale a value based on the [ScalingType] provided.
  double rescale(Size screenSize, ScalingType scalingType, value, {ScalingSize scalingSize = ScalingSize.small}) {
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

    return value * sizeFactor;
  }
}