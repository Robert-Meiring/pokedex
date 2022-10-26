import 'package:get_it/get_it.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_bloc.dart';

final sl = GetIt.instance;

class RegisterFactory {
  void setup() {
    sl.registerLazySingleton<PokemonBloc>(() => PokemonBloc());
  }
}
