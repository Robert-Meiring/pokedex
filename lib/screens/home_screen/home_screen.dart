import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/screens/home_screen/widgets/pokemon_grid.dart';
import 'package:pokedex/shared/logic/features/pokemon/entities/pokemon_small.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_bloc.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_events.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_states.dart';
import 'package:pokedex/shared/register_factory/register_factory.dart';
import 'package:pokedex/shared/styling/pokemon_styling.dart';
import 'package:pokedex/shared/widgets/animations/pokemon_animations.dart';
import 'package:pokedex/shared/widgets/loaders/pokemon_loaders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //assign our Bloc variable via DI
  final PokemonBloc _bloc = sl.get<PokemonBloc>();
  List<PokemonSmall> _list = [];

  @override
  void initState() {
    //Add event to bloc to fetch all our pokemon upon widget initial state
    _bloc.add(GetAllPokemon());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PokemonColors.altBackground,
      body: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          //listen for state when our business logic has completed and all our pokemon are returned
          if (state is FetchingAllPokemonSuccess) {
            _list = state.pokemon;
            //setState used here, a better alternative would be to use BlocConsumer and keep the widget Stateless, but in this case setState will suffice
            setState(() {});
          }
        },
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(PokemonRadius.defaultBorderRadius),
                  bottomRight:
                      Radius.circular(PokemonRadius.defaultBorderRadius)),
              elevation: 4,
              color: PokemonColors.background,
              child: SizedBox(
                width: double.infinity,
                height: screenH / 6,
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/logos/logo.png',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PokemonDefaultAnimator(
                //list is empty = no data yet so display a loader || list is not empty = display our gridview
                child: _list.isNotEmpty
                    ? PokemonGrid(list: _list)
                    : const Center(child: DefaultPokemonLoader()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
