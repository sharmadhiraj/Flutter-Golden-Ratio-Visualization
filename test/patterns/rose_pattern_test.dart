import 'package:flutter_golden_ratio_visualization/patterns/rose_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final RosePattern pattern = RosePattern();

  test("starts at the tip of a petal", () {
    expect(pattern.points.first.dx, closeTo(1, 1e-12));
    expect(pattern.points.first.dy, closeTo(0, 1e-12));
  });

  test("does not close after a whole number of turns", () {
    final Offset oneTurnLater = pattern.points[RosePattern.stepsPerTurn];
    expect((oneTurnLater - pattern.points.first).distance, greaterThan(0.1));
  });
}
