import 'package:equatable/equatable.dart';

abstract class PokemonEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllPokemon extends PokemonEvents {}

class GetIndividualPokemon extends PokemonEvents {
  final String url;

  GetIndividualPokemon({required this.url});
}
