import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<Pattern> patterns = createPatterns();

  test("names are unique", () {
    final Set<String> names = patterns.map((p) => p.name).toSet();
    expect(names.length, patterns.length);
  });

  for (final Pattern pattern in patterns) {
    group(pattern.name, () {
      test("has points within the unit circle", () {
        expect(pattern.points.length, greaterThan(1));
        expect(pattern.points.every((p) => p.distance <= 1 + 1e-9), isTrue);
      });

      test("stays under the point limit", () {
        expect(pattern.points.length, lessThanOrEqualTo(Pattern.maxPoints));
      });

      test("has a description and a positive duration", () {
        expect(pattern.description, isNotEmpty);
        expect(pattern.duration, greaterThan(Duration.zero));
      });
    });
  }
}
