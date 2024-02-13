import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/util/common.dart';
import 'package:flutter_golden_ratio_visualization/util/constant.dart';

class Arm extends StatelessWidget {
  const Arm({
    required this.angle,
    required this.length,
    required this.width,
    required this.height,
    this.offset = const Offset(0, 0),
    super.key,
  });

  final double angle;
  final double length;
  final double width;
  final double height;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    if (length == 0) return const SizedBox.shrink();
    return Container(
      margin: EdgeInsets.only(
        left: (width / 2) - (Constant.armWidth / 1) + offset.dx,
        top: (height / 2) - length + offset.dy,
      ),
      child: Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: CommonUtils.degreesToRadians(angle),
        child: Container(
          color: Colors.white,
          width: Constant.armWidth,
          height: length,
        ),
      ),
    );
  }
}
