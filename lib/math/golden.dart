import 'dart:math';
import 'dart:ui';

final double phi = (1 + sqrt(5)) / 2;

/// The angle (radians) that splits a full turn in the ratio 1 : phi.
final double goldenAngle = 2 * pi * (1 - 1 / phi);

Offset polar(double radius, double angle) {
  return Offset(radius * cos(angle), radius * sin(angle));
}
