import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/main.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("shows each pattern's description when selected", (tester) async {
    await tester.pumpWidget(const GoldenRatioApp());

    for (final Pattern pattern in createPatterns()) {
      await tester.ensureVisible(find.text(pattern.name));
      await tester.tap(find.text(pattern.name));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text(pattern.description), findsOneWidget);
    }

    await tester.pumpAndSettle(const Duration(seconds: 30));
  });

  testWidgets("pauses and resumes from the controls and by tapping the canvas", (tester) async {
    await tester.pumpWidget(const GoldenRatioApp());
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byTooltip("Pause"));
    await tester.pump();
    expect(find.byTooltip("Play"), findsOneWidget);

    await tester.tapAt(const Offset(400, 200));
    await tester.pump();
    expect(find.byTooltip("Pause"), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 30));
  });

  testWidgets("a faster speed finishes sooner", (tester) async {
    await tester.pumpWidget(const GoldenRatioApp());
    await tester.tap(find.text("2.0x"));
    await tester.pump();

    await tester.pump(const Duration(seconds: 13));
    expect(find.byTooltip("Play"), findsOneWidget);
  });

  testWidgets("does not overflow on a narrow screen", (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const GoldenRatioApp());
    await tester.pump(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
  });
}
