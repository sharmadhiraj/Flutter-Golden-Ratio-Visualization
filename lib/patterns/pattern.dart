import 'dart:ui';

/// A drawable curve in unit space (every point lies within radius 1 of the origin).
abstract class Pattern {
  static const int maxPoints = 50000;

  String get name;
  String get description;
  Duration get duration;
  PointMode get pointMode;
  double get strokeWidth;
  List<Offset> get points;

  /// Moving parts (e.g. arm ends) to draw from the origin while the pattern grows.
  List<Offset> jointsAt(int index) => const [];
}
