import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/star_whirl_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final StarWhirlPattern pattern = StarWhirlPattern();
  const int lapSteps = StarWhirlPattern.stepsPerEdge * 5;

  test("starts at the top, on the unit circle", () {
    expect(pattern.points.first.dx, closeTo(0, 1e-12));
    expect(pattern.points.first.dy, closeTo(-1, 1e-12));
  });

  test("each lap shrinks by phi squared", () {
    final double ratio = pattern.points[lapSteps].distance / pattern.points.first.distance;
    expect(ratio, closeTo(1 / (phi * phi), 1e-9));
  });

  test("a lap lands on the same direction as it started", () {
    final double cross = pattern.points[lapSteps].dx * pattern.points.first.dy -
        pattern.points[lapSteps].dy * pattern.points.first.dx;
    expect(cross, closeTo(0, 1e-9));
  });
}
