import 'package:equatable/equatable.dart';
import 'package:pokedex/shared/logic/features/pokemon/entities/pokemon_detailed.dart';
import 'package:pokedex/shared/logic/features/pokemon/entities/pokemon_small.dart';

//Our States abstract class is used by our BLoC to communicate back to our widgets.

abstract class PokemonStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPokemonState extends PokemonStates {}

class FetchingAllPokemonBusy extends PokemonStates {}

class FetchingAllPokemonSuccess extends PokemonStates {
  final List<PokemonSmall> pokemon;

  FetchingAllPokemonSuccess({required this.pokemon});
}

class FetchingAllPokemonFailed extends PokemonStates {}

class FetchingIndividualPokemonBusy extends PokemonStates {}

class FetchingIndividualPokemonSuccess extends PokemonStates {
  final PokemonDetailed pokemon;

  FetchingIndividualPokemonSuccess({required this.pokemon});
}

class FetchingIndividualPokemonFailed extends PokemonStates {}
