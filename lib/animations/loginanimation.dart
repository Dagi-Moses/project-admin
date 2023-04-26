import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    

    return TweenAnimationBuilder(
      //delay: Duration(milliseconds: (500 * delay).round()),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      child: child,
      builder: (context,  animation, child,) => Opacity(
        opacity: 1.0,
        child: Transform.translate(
          offset: Offset(0, -30), 
          child: child
        ),
      ),
    );
  }
}