import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/arms_pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/chords_pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/golden_arcs_pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/golden_spiral_pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/lissajous_pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/rose_pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/star_whirl_pattern.dart';
import 'package:flutter_golden_ratio_visualization/patterns/sunflower_pattern.dart';

List<Pattern> createPatterns() => [
      ArmsPattern(
        name: "Two arms",
        description: "The second arm spins φ times faster than the first.",
        duration: const Duration(seconds: 24),
        arms: [const Arm(length: 1, speed: 1), Arm(length: 1, speed: phi)],
      ),
      ArmsPattern(
        name: "Three arms",
        description: "Arms spinning at 1, φ and φ² times the base speed.",
        duration: const Duration(seconds: 24),
        arms: [
          const Arm(length: 1, speed: 1),
          Arm(length: 1, speed: phi),
          Arm(length: 1, speed: phi * phi),
        ],
      ),
      ArmsPattern(
        name: "Spirograph",
        description: "Two arms with lengths in ratio 1 : φ, turning in opposite directions.",
        duration: const Duration(seconds: 24),
        arms: [const Arm(length: 1, speed: 1), Arm(length: phi, speed: -1 / phi)],
      ),
      SunflowerPattern(),
      GoldenSpiralPattern(),
      GoldenArcsPattern(),
      RosePattern(),
      LissajousPattern(),
      StarWhirlPattern(),
      ChordsPattern(),
    ];
