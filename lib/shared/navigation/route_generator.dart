import 'package:flutter/material.dart';
import 'package:pokedex/screens/home_screen/home_screen.dart';
import 'package:pokedex/screens/pokemon_view_screen/pokemon_view_screen.dart';

//this class is used for clean navigation, named routes
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/pokemonview':
        final String _url = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => PokemonViewScreen(
                  url: _url,
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
