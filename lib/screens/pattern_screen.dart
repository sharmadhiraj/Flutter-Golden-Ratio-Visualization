import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern_catalog.dart';
import 'package:flutter_golden_ratio_visualization/rendering/pattern_painter.dart';
import 'package:flutter_golden_ratio_visualization/screens/widgets/pattern_chips.dart';
import 'package:flutter_golden_ratio_visualization/screens/widgets/playback_controls.dart';

class PatternScreen extends StatefulWidget {
  const PatternScreen({super.key});

  @override
  State<PatternScreen> createState() => _PatternScreenState();
}

class _PatternScreenState extends State<PatternScreen> with SingleTickerProviderStateMixin {
  final List<Pattern> _patterns = createPatterns();
  late final AnimationController _controller = AnimationController(vsync: this);
  int _selected = 0;
  double _speed = 1;

  Pattern get _pattern => _patterns[_selected];

  Duration get _scaledDuration => _pattern.duration * (1 / _speed);

  @override
  void initState() {
    super.initState();
    _replay();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replay() {
    _controller
      ..duration = _scaledDuration
      ..forward(from: 0);
  }

  void _togglePlay() {
    setState(() {
      if (_controller.isAnimating) {
        _controller.stop();
      } else if (_controller.isCompleted) {
        _replay();
      } else {
        _controller.forward();
      }
    });
  }

  void _select(int index) {
    setState(() => _selected = index);
    _replay();
  }

  void _setSpeed(double speed) {
    setState(() => _speed = speed);
    _controller.duration = _scaledDuration;
    if (_controller.isAnimating) _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 12,
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _togglePlay,
                child: SizedBox.expand(
                  child: CustomPaint(
                    painter: PatternPainter(pattern: _pattern, progress: _controller),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _pattern.description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            ListenableBuilder(
              listenable: _controller,
              builder: (context, _) => PlaybackControls(
                isPlaying: _controller.isAnimating,
                speed: _speed,
                onTogglePlay: _togglePlay,
                onReplay: _replay,
                onSpeedChanged: _setSpeed,
              ),
            ),
            PatternChips(
              names: [for (final Pattern pattern in _patterns) pattern.name],
              selected: _selected,
              onSelected: _select,
            ),
          ],
        ),
      ),
    );
  }
}
