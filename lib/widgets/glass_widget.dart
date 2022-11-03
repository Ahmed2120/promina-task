import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassWidget extends StatelessWidget {
  const GlassWidget({Key? key, required this.child, required this.dSize}) : super(key: key);

  final Widget child;
  final Size dSize;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      borderRadius: 40,
      blur: 3,
      alignment: Alignment.bottomCenter,
      border: 1,
      linearGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white60,
            Colors.white10
          ],
          stops: [
            0.3,
            1,
          ]),
      borderGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white
          ],
          stops: [
            0.2,
            0.9,
          ]),
      width: dSize.width * 0.8,
      height: dSize.height * 0.5,
      child: child,
    );
  }
}
