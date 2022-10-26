import 'package:flutter/material.dart';
import 'package:pokedex/shared/styling/pokemon_styling.dart';

class DefaultPokemonText extends StatelessWidget {
  const DefaultPokemonText(
      {Key? key, required this.text, this.color, this.scale, this.bold})
      : super(key: key);

  final String text;
  final Color? color;
  final double? scale;
  final bool? bold;

  //Reusable Text widget

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? PokemonColors.text,
          fontWeight: bold != null
              ? bold!
                  ? FontWeight.bold
                  : FontWeight.normal
              : FontWeight.normal),
      textScaleFactor: scale ?? 1,
    );
  }
}
