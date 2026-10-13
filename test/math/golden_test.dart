import 'dart:math';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("phi satisfies phi^2 = phi + 1", () {
    expect(phi * phi, closeTo(phi + 1, 1e-12));
  });

  test("golden angle is about 137.5 degrees", () {
    expect(goldenAngle * 180 / pi, closeTo(137.5078, 1e-4));
  });

  test("polar converts radius and angle to an offset", () {
    final Offset offset = polar(2, pi / 2);
    expect(offset.dx, closeTo(0, 1e-12));
    expect(offset.dy, closeTo(2, 1e-12));
  });
}
