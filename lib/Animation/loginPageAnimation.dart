
import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

class LoginAnime extends StatelessWidget {
  final double delay;
  final Widget child;
  const LoginAnime({super.key, required this.delay,required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
    ..tween('opacity', Tween(begin: 0.0,end: 1.0),
    duration: const Duration(milliseconds: 400)).thenTween(
        'y', Tween(begin: -30.0,end: 0.0),
        duration: const Duration(milliseconds: 450),curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
        tween: tween,
        duration: tween.duration,
        child: child,
        builder: (context, animation, child) => Opacity(
            opacity: animation.get("opacity"),
          child: Transform.translate(
              offset: Offset(0, animation.get("y")),
            child: child,
          ),
        ),
    );
  }
}
