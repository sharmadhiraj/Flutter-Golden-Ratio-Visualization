import 'dart:math';
import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

/// Quarter circles, each phi times smaller than the last, joined end to end.
/// This is the classic spiral drawn inside a Fibonacci tiling.
class GoldenArcsPattern extends Pattern {
  static const int arcs = 10;
  static const int stepsPerArc = 90;

  @override
  String get name => "Arcs";

  @override
  String get description => "Quarter circles shrinking by φ, as in a Fibonacci tiling.";

  @override
  Duration get duration => const Duration(seconds: 6);

  @override
  PointMode get pointMode => PointMode.polygon;

  @override
  double get strokeWidth => 2;

  @override
  late final List<Offset> points = _centered(_trace());

  List<Offset> _trace() {
    final List<Offset> trace = [Offset.zero];
    double heading = 0;
    double radius = 1;
    for (int arc = 0; arc < arcs; arc++) {
      final Offset center = trace.last + polar(radius, heading + pi / 2);
      for (int step = 1; step <= stepsPerArc; step++) {
        final double sweep = (pi / 2) * step / stepsPerArc;
        trace.add(center + polar(radius, heading - pi / 2 + sweep));
      }
      heading += pi / 2;
      radius /= phi;
    }
    return trace;
  }

  /// Moves the spiral's eye to the origin and scales it into the unit circle.
  List<Offset> _centered(List<Offset> trace) {
    final Offset eye = trace.last;
    final double reach = trace.map((p) => (p - eye).distance).reduce(max);
    return [for (final Offset p in trace) (p - eye) / reach];
  }
}
