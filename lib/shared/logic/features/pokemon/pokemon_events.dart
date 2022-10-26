import 'package:equatable/equatable.dart';

//The events abstract class is used as an efficient way to send data and instructions to our BLoC

abstract class PokemonEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllPokemon extends PokemonEvents {}

class GetIndividualPokemon extends PokemonEvents {
  final String url;

  GetIndividualPokemon({required this.url});
}
