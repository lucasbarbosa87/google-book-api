import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoadinAnimationWidget extends StatefulWidget {
  final Key? animationKey;
  final bool? repeat;
  final double? height;
  final double? width;
  final AnimationController? controller;
  final BoxFit? fit;

  const AppLoadinAnimationWidget({
    this.animationKey,
    this.repeat = true,
    this.height,
    this.width,
    this.controller,
    this.fit,
  }) : super(key: animationKey);
  @override
  AppLoadinAnimationWidgetState createState() =>
      AppLoadinAnimationWidgetState();
}

class AppLoadinAnimationWidgetState extends State<AppLoadinAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Lottie.asset(
        "assets/animations/loading.json",
        repeat: widget.repeat,
        fit: widget.fit ?? BoxFit.cover,
        controller: widget.controller,
        onLoaded: (composition) {
          if (widget.controller != null) {
            widget.controller!
              ..duration = composition.duration
              ..forward();
          }
        },
      ),
    );
  }
}
