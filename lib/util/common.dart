import 'dart:math';

import 'package:flutter/material.dart';

class CommonUtils {
  static double degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  static Offset calculateEndpoint(double length, double degrees) {
    final double thetaRadians = degreesToRadians(degrees);
    return Offset(length * sin(thetaRadians), -1 * length * cos(thetaRadians));
  }
}
