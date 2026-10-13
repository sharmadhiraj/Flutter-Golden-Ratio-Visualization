import 'package:flutter/animation.dart';
import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/patterns/sunflower_pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/chords_pattern.dart';
import 'package:flutter_golden_ratio_visualization/rendering/pattern_painter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SunflowerPattern pattern = SunflowerPattern();

  PatternPainter painterAt(double progress) => PatternPainter(
        pattern: pattern,
        progress: AlwaysStoppedAnimation(progress),
      );

  test("visible count follows progress", () {
    expect(painterAt(0).visibleCount, 0);
    expect(painterAt(0.5).visibleCount, (pattern.points.length / 2).ceil());
    expect(painterAt(1).visibleCount, pattern.points.length);
  });

  test("repaints only when the pattern changes", () {
    final PatternPainter painter = painterAt(0.5);
    expect(painter.shouldRepaint(painterAt(0.9)), isFalse);
    final PatternPainter other = PatternPainter(
      pattern: ChordsPattern(),
      progress: const AlwaysStoppedAnimation(0.5),
    );
    expect(painter.shouldRepaint(other), isTrue);
  });

  test("paints at every progress without throwing", () {
    for (final double progress in [0.0, 0.01, 0.5, 1.0]) {
      final PictureRecorder recorder = PictureRecorder();
      painterAt(progress).paint(Canvas(recorder), const Size(400, 800));
      recorder.endRecording();
    }
  });
}
