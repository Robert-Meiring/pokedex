import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pokedex/shared/styling/pokemon_styling.dart';

class DefaultPokemonLoader extends StatelessWidget {
  const DefaultPokemonLoader({Key? key}) : super(key: key);

  //Reusable loader widget

  @override
  Widget build(BuildContext context) {
    return SpinKitSquareCircle(
      color: PokemonColors.altAccent,
      size: MediaQuery.of(context).size.width / 8,
    );
  }
}
