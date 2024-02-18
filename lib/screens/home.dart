import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/components/arm.dart';
import 'package:flutter_golden_ratio_visualization/painter/app_painter.dart';
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
  double _armLength = 0;
  final List<Offset> _points = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Stack(
      children: [
        if (!_shouldTerminate()) ...[
          Arm(
            angle: _angle,
            width: _width,
            height: _height,
            length: _armLength,
          ),
          Arm(
            angle: _angle * Constant.goldenRatio,
            width: _width,
            height: _height,
            length: _armLength,
            offset: CommonUtils.calculateEndpoint(_armLength, _angle),
          ),
        ],
        CustomPaint(painter: AppPainter(_points)),
      ],
    );
  }

  void _init() {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _armLength = ((_width > _height) ? _height : _width) * 0.24;
    _timer = Timer.periodic(
      const Duration(microseconds: Constant.animationDurationMs),
      (_) {
        setState(() => _angle += 0.01);
        _addPoint();
        if (_shouldTerminate()) {
          _timer.cancel();
        }
      },
    );
  }

  void _addPoint() {
    final Offset offset = CommonUtils.calculateEndpoint(_armLength, _angle);
    final Offset offset2 = CommonUtils.calculateEndpoint(
      _armLength,
      _angle * Constant.goldenRatio,
    );
    setState(() {
      _points.add(
        Offset(
          _width / 2 + offset.dx + offset2.dx,
          _height / 2 + offset.dy + offset2.dy,
        ),
      );
    });
  }

  bool _shouldTerminate() {
    return _angle > Constant.terminationAngle;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
