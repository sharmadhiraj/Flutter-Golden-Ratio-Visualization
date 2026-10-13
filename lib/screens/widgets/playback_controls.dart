import 'package:flutter/material.dart';

class PlaybackControls extends StatelessWidget {
  const PlaybackControls({
    required this.isPlaying,
    required this.speed,
    required this.onTogglePlay,
    required this.onReplay,
    required this.onSpeedChanged,
    super.key,
  });

  static const List<double> speeds = [0.5, 1, 2];

  final bool isPlaying;
  final double speed;
  final VoidCallback onTogglePlay;
  final VoidCallback onReplay;
  final ValueChanged<double> onSpeedChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      children: [
        IconButton(
          tooltip: isPlaying ? "Pause" : "Play",
          onPressed: onTogglePlay,
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        ),
        IconButton(
          tooltip: "Replay",
          onPressed: onReplay,
          icon: const Icon(Icons.replay),
        ),
        SegmentedButton<double>(
          showSelectedIcon: false,
          selected: {speed},
          onSelectionChanged: (selection) => onSpeedChanged(selection.first),
          segments: [
            for (final double value in speeds)
              ButtonSegment(
                value: value,
                label: Semantics(
                  button: true,
                  label: "Speed $value times",
                  child: Text("${value}x"),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
