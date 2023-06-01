import 'package:flutter/material.dart';

class Height extends StatelessWidget {
  const Height(
    this.height, {
    Key? key,
  }) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class Width extends StatelessWidget {
  const Width(
    this.width, {
    Key? key,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
