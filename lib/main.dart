import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/screens/home.dart';
import 'package:flutter_golden_ratio_visualization/util/constant.dart';

void main() {
  runApp(const GoldenRationVisualizationApp());
}

class GoldenRationVisualizationApp extends StatelessWidget {
  const GoldenRationVisualizationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomeScreen(),
    );
  }
}
