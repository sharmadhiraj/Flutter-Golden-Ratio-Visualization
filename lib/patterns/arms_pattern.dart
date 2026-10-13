import 'dart:math';
import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

class Arm {
  const Arm({required this.length, required this.speed});

  final double length;

  /// Rotations per rotation of the first arm (negative spins the other way).
  final double speed;
}

/// Chained rotating arms. The tip of the last arm traces the curve.
class ArmsPattern extends Pattern {
  ArmsPattern({
    required this.name,
    required this.description,
    required this.duration,
    required this.arms,
  }) : _totalLength = arms.fold(0, (sum, arm) => sum + arm.length);

  static const int turns = 89;
  static const int stepsPerTurn = 360;

  @override
  final String name;

  @override
  final String description;

  @override
  final Duration duration;

  final List<Arm> arms;
  final double _totalLength;

  @override
  PointMode get pointMode => PointMode.polygon;

  @override
  double get strokeWidth => 1;

  @override
  late final List<Offset> points = List.generate(
    turns * stepsPerTurn,
    (i) => jointsAt(i).last,
  );

  @override
  List<Offset> jointsAt(int index) {
    final double angle = 2 * pi * index / stepsPerTurn;
    final List<Offset> joints = [];
    Offset tip = Offset.zero;
    for (final Arm arm in arms) {
      tip += polar(arm.length / _totalLength, angle * arm.speed);
      joints.add(tip);
    }
    return joints;
  }
}
