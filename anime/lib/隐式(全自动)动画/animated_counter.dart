import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final Duration duration;
  final double value;
  const AnimatedCounter({
    super.key,
    required this.value,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      // tween: Tween(begin: 7.0, end: 8.0),
      tween: Tween(end: value),
      builder: (context, value, child) {
        final whole = value ~/ 1; //取整除
        final decimal = value - whole; //取小数作为完成度
        return Stack(
          children: [
            Positioned(
              top: -100 * decimal, // 0 -> -100
              child: Opacity(
                opacity: 1.0 - decimal, // 1.0 -> 0.0
                child: Text('$whole', style: TextStyle(fontSize: 100)),
              ),
            ),
            Positioned(
              top: 100 - decimal * 100, // 100 -> 0
              child: Opacity(
                opacity: decimal, // 0.0 -> 1.0
                child: Text('${whole + 1}', style: TextStyle(fontSize: 100)),
              ),
            ),
          ],
        );
      },
    );
  }
}
