import 'dart:math';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/arms_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ArmsPattern twoArms = ArmsPattern(
    name: "Two arms",
    description: "test",
    duration: const Duration(seconds: 1),
    arms: [const Arm(length: 1, speed: 1), Arm(length: 1, speed: phi)],
  );

  test("has one point per step", () {
    expect(twoArms.points.length, ArmsPattern.turns * ArmsPattern.stepsPerTurn);
  });

  test("stays within the unit circle", () {
    expect(twoArms.points.every((p) => p.distance <= 1 + 1e-9), isTrue);
  });

  test("starts fully extended along the x axis", () {
    expect(twoArms.points.first.dx, closeTo(1, 1e-12));
    expect(twoArms.points.first.dy, closeTo(0, 1e-12));
  });

  test("has one joint per arm, ending at the traced point", () {
    final List<Offset> joints = twoArms.jointsAt(100);
    expect(joints.length, 2);
    expect(joints.last, twoArms.points[100]);
    expect(joints.first.distance, closeTo(0.5, 1e-12));
    expect((joints.last - joints.first).distance, closeTo(0.5, 1e-12));
  });

  test("second arm spins phi times faster", () {
    const int quarterTurn = ArmsPattern.stepsPerTurn ~/ 4;
    final List<Offset> joints = twoArms.jointsAt(quarterTurn);
    final Offset expected = polar(0.5, phi * pi / 2);
    expect(((joints.last - joints.first) - expected).distance, closeTo(0, 1e-9));
  });

  test("arm lengths are normalized by their sum", () {
    final ArmsPattern uneven = ArmsPattern(
      name: "Uneven",
      description: "test",
      duration: const Duration(seconds: 1),
      arms: [const Arm(length: 1, speed: 1), Arm(length: phi, speed: -1)],
    );
    expect(uneven.jointsAt(0).first.distance, closeTo(1 / (1 + phi), 1e-12));
    expect(uneven.points.first.distance, closeTo(1, 1e-12));
  });
}
