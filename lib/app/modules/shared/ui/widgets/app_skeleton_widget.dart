import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppSkeletonWidget extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;
  const AppSkeletonWidget({
    required this.height,
    required this.width,
    this.baseColor = Colors.blue,
    this.highlightColor = Colors.white70,
    this.borderRadius = 5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: baseColor,
          ),
          width: width,
          height: height,
        ),
      ),
    );
  }
}
