import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/shared/logic/features/pokemon/entities/pokemon_detailed.dart';
import 'package:pokedex/shared/logic/features/pokemon/entities/pokemon_small.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_events.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_states.dart';

class PokemonBloc extends Bloc<PokemonEvents, PokemonStates> {
  PokemonBloc() : super(InitialPokemonState()) {
    on<GetAllPokemon>((event, emit) async {
      emit(FetchingAllPokemonBusy());
      try {
        List<PokemonSmall> _pokemonList = [];
        const _url = 'https://pokeapi.co/api/v2/pokemon/?limit=9000';
        var _response = await http.get(
          Uri.parse(_url),
        );
        final Map _result = json.decode(_response.body);
        final List _resultPokemon = _result['results'];

        for (int i = 0; i < _resultPokemon.length; i++) {
          final int tempID = i + 1;
          _pokemonList.add(PokemonSmall(
              name: _resultPokemon[i]['name'],
              url: _resultPokemon[i]['url'],
              number: tempID,
              imageUrl:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$tempID.png'));
        }

        emit(FetchingAllPokemonSuccess(pokemon: _pokemonList));
        emit(InitialPokemonState());
      } catch (e) {
        emit(FetchingAllPokemonFailed());
      }
    });

    on<GetIndividualPokemon>((event, emit) async {
      emit(FetchingIndividualPokemonBusy());
      try {
        List<Ability> _abilityList = [];
        List<Move> _movesList = [];
        List<Stat> _statsList = [];
        List<Type> _typesList = [];

        final _url = event.url;
        var _response = await http.get(
          Uri.parse(_url),
        );
        final Map _result = json.decode(_response.body);

        for (int i = 0; i < _result['abilities'].length; i++) {
          _abilityList
              .add(Ability(name: _result['abilities'][i]['ability']['name']));
        }

        for (int i = 0; i < _result['moves'].length; i++) {
          _movesList.add(Move(name: _result['moves'][i]['move']['name']));
        }

        for (int i = 0; i < _result['stats'].length; i++) {
          _statsList.add(Stat(
              name: _result['stats'][i]['stat']['name'],
              base: _result['stats'][i]['base_stat'],
              effort: _result['stats'][i]['effort']));
        }

        for (int i = 0; i < _result['types'].length; i++) {
          _typesList.add(Type(name: _result['types'][i]['type']['name']));
        }

        emit(
          FetchingIndividualPokemonSuccess(
            pokemon: PokemonDetailed(
              name: _result['name'],
              id: _result['id'],
              weight: _result['weight'],
              baseExperience: _result['base_experience'],
              abilities: _abilityList,
              moves: _movesList,
              stats: _statsList,
              types: _typesList,
              imageUrl:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/' +
                      _result['id'].toString() +
                      '.png',
              species: _result['species']['name'],
            ),
          ),
        );
        emit(InitialPokemonState());
      } catch (e) {
        emit(FetchingIndividualPokemonFailed());
      }
    });
  }
}
