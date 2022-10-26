import 'package:flutter/material.dart';

class PokemonDefaultAnimator extends StatelessWidget {
  const PokemonDefaultAnimator({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  //Reusable animator widget

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.linearToEaseOut,
      switchOutCurve: Curves.linearToEaseOut,
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          child: child,
          scale: animation,
        ),
      ),
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}
