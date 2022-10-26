import 'package:get_it/get_it.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_bloc.dart';

//Dependency Injection - Global variable to access our dependencies

final sl = GetIt.instance;

class RegisterFactory {
  void setup() {
    //function called on startup to register all our dependencies
    //note - shared prefs works great with GetIt as the instance is a future, await only has to be used once here
    sl.registerLazySingleton<PokemonBloc>(() => PokemonBloc());
  }
}
