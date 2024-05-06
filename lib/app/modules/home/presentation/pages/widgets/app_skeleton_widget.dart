import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;
  const LoadingWidget({
    required this.height,
    required this.width,
    this.baseColor = Colors.blue,
    this.highlightColor = Colors.white70,
    this.borderRadius = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.secondary,
        highlightColor: Theme.of(context).primaryColor,
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
