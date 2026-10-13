import 'package:flutter_golden_ratio_visualization/patterns/chords_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ChordsPattern pattern = ChordsPattern();

  test("every point is on the unit circle", () {
    expect(pattern.points.length, ChordsPattern.pointTotal);
    expect(pattern.points.every((p) => (p.distance - 1).abs() < 1e-9), isTrue);
  });

  test("consecutive chords have equal length", () {
    final double first = (pattern.points[1] - pattern.points[0]).distance;
    final double later = (pattern.points[201] - pattern.points[200]).distance;
    expect(later, closeTo(first, 1e-9));
  });
}
