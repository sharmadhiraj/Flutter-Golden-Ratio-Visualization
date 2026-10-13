import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/screens/pattern_screen.dart';

void main() {
  runApp(const GoldenRatioApp());
}

class GoldenRatioApp extends StatelessWidget {
  const GoldenRatioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Golden Ratio Visualization",
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const PatternScreen(),
    );
  }
}
