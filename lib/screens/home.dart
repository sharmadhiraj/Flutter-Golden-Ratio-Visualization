import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/components/arm.dart';
import 'package:flutter_golden_ratio_visualization/util/common.dart';
import 'package:flutter_golden_ratio_visualization/util/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  double _angle = 0;
  double _width = 0;
  double _height = 0;
  double armLength = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Arm(
          angle: _angle,
          width: _width,
          height: _height,
          length: armLength,
        ),
        Arm(
          angle: _angle * Constant.goldenRatio,
          width: _width,
          height: _height,
          length: armLength,
          offset: CommonUtils.calculateEndpoint(armLength, _angle),
        ),
      ],
    );
  }

  void _init() {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    armLength = ((_width > _height) ? _height : _width) * 0.2;
    _timer = Timer.periodic(
      const Duration(milliseconds: Constant.animationDurationMs),
      (_) => setState(() => _angle++),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
