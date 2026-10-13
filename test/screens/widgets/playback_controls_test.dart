import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/screens/widgets/playback_controls.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pump(
    WidgetTester tester, {
    bool isPlaying = true,
    VoidCallback? onTogglePlay,
    VoidCallback? onReplay,
    ValueChanged<double>? onSpeedChanged,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlaybackControls(
            isPlaying: isPlaying,
            speed: 1,
            onTogglePlay: onTogglePlay ?? () {},
            onReplay: onReplay ?? () {},
            onSpeedChanged: onSpeedChanged ?? (_) {},
          ),
        ),
      ),
    );
  }

  testWidgets("shows pause while playing and play while paused", (tester) async {
    await pump(tester);
    expect(find.byTooltip("Pause"), findsOneWidget);
    await pump(tester, isPlaying: false);
    expect(find.byTooltip("Play"), findsOneWidget);
  });

  testWidgets("reports taps", (tester) async {
    int toggles = 0;
    int replays = 0;
    double? speed;
    await pump(
      tester,
      onTogglePlay: () => toggles++,
      onReplay: () => replays++,
      onSpeedChanged: (value) => speed = value,
    );

    await tester.tap(find.byTooltip("Pause"));
    await tester.tap(find.byTooltip("Replay"));
    await tester.tap(find.text("2.0x"));

    expect([toggles, replays, speed], [1, 1, 2.0]);
  });

  testWidgets("offers only the bounded speeds", (tester) async {
    await pump(tester);
    expect(PlaybackControls.speeds, [0.5, 1, 2]);
    expect(find.byType(ButtonSegment<double>), findsNothing);
    expect(find.text("0.5x"), findsOneWidget);
    expect(find.text("1.0x"), findsOneWidget);
    expect(find.text("2.0x"), findsOneWidget);
  });
}
