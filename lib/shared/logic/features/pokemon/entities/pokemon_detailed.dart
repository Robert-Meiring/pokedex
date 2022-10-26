//More detailed entities 

//POKEMON
class PokemonDetailed {
  final String name;
  final int id;
  final int weight;
  final int baseExperience;
  final List<Ability> abilities;
  final List<Move> moves;
  final List<Stat> stats;
  final List<Type> types;
  final String imageUrl;
  final String species;

  PokemonDetailed(
      {required this.name,
      required this.id,
      required this.weight,
      required this.baseExperience,
      required this.abilities,
      required this.moves,
      required this.stats,
      required this.types,
      required this.imageUrl,
      required this.species});
}


//STATS ETC

class Ability {
  final String name;

  Ability({required this.name});
}

class Move {
  final String name;

  Move({required this.name});
}

class Stat {
  final String name;
  final int base;
  final int effort;

  Stat({required this.name, required this.base, required this.effort});
}

class Type {
  final String name;

  Type({required this.name});
}
