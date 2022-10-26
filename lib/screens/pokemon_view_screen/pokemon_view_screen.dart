import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/shared/logic/features/pokemon/entities/pokemon_detailed.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_bloc.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_events.dart';
import 'package:pokedex/shared/logic/features/pokemon/pokemon_states.dart';
import 'package:pokedex/shared/register_factory/register_factory.dart';
import 'package:pokedex/shared/styling/pokemon_styling.dart';
import 'package:pokedex/shared/widgets/animations/pokemon_animations.dart';
import 'package:pokedex/shared/widgets/loaders/pokemon_loaders.dart';
import 'package:pokedex/shared/widgets/text/pokemon_text.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonViewScreen extends StatefulWidget {
  const PokemonViewScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<PokemonViewScreen> createState() => _PokemonViewScreenState();
}

class _PokemonViewScreenState extends State<PokemonViewScreen> {
  //assign our Bloc variable via DI
  final PokemonBloc _bloc = sl.get<PokemonBloc>();
  //Init our entity variable as null, as there is still an API call to make to retrieve the data
  PokemonDetailed? _pokemon;

  @override
  void initState() {
    super.initState();
    //Add event to bloc to fetch individual pokemon upon widget initial state
    _bloc.add(GetIndividualPokemon(url: widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Stack(
          children: [
            BlocListener(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is FetchingIndividualPokemonSuccess) {
                    //listen for state when our business logic has completed and our pokemon is returned
                    //assign the state result to our null variable
                    _pokemon = state.pokemon;
                    //setState used here, a better alternative would be to use BlocConsumer and keep the widget Stateless, but in this case setState will suffice
                    setState(() {});
                  }
                },
                //wrap widget with our reusable animator class, used for smooth transitions when switching between widgets
                child: PokemonDefaultAnimator(
                    //check if we have received data yet, if so, display the relevant widget, else just a loading indicator
                    child: _pokemon != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        FadeInImage.memoryNetwork(
                                          image: _pokemon!.imageUrl,
                                          placeholder: kTransparentImage,
                                          fit: BoxFit.cover,
                                        ),
                                        DefaultPokemonText(
                                          text: '#' + _pokemon!.id.toString(),
                                          bold: true,
                                          scale: 1.2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: DefaultPokemonText(
                                    text: _pokemon!.name.toUpperCase(),
                                    bold: true,
                                    scale: 1.8,
                                    color: PokemonColors.altText,
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const DefaultPokemonText(
                                          text: 'WEIGHT - ',
                                          bold: true,
                                          scale: 1.2,
                                        ),
                                        DefaultPokemonText(
                                          text: _pokemon!.weight.toString(),
                                          bold: true,
                                          scale: 1.2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const DefaultPokemonText(
                                          text: 'BASE XP - ',
                                          bold: true,
                                          scale: 1.2,
                                        ),
                                        DefaultPokemonText(
                                          text: _pokemon!.baseExperience
                                              .toString(),
                                          bold: true,
                                          scale: 1.2,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DefaultPokemonText(
                                  text: 'STATS',
                                  bold: true,
                                  color: PokemonColors.text.withOpacity(0.5),
                                  scale: 1.2,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: false,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _pokemon!.stats.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          color: PokemonColors.altAccent,
                                          elevation: 4,
                                          borderRadius: BorderRadius.circular(
                                              PokemonRadius
                                                  .defaultBorderRadius),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DefaultPokemonText(
                                                  text: _pokemon!
                                                      .stats[index].name
                                                      .toUpperCase(),
                                                  bold: true,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: DefaultPokemonText(
                                                    text: _pokemon!
                                                        .stats[index].base
                                                        .toString(),
                                                    bold: true,
                                                    color:
                                                        PokemonColors.altText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DefaultPokemonText(
                                  text: 'ABILITIES',
                                  bold: true,
                                  color: PokemonColors.text.withOpacity(0.5),
                                  scale: 1.2,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: false,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _pokemon!.abilities.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          color: PokemonColors.altText,
                                          elevation: 4,
                                          borderRadius: BorderRadius.circular(
                                              PokemonRadius
                                                  .defaultBorderRadius),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DefaultPokemonText(
                                                  text: _pokemon!
                                                      .abilities[index].name
                                                      .toUpperCase(),
                                                  color:
                                                      PokemonColors.background,
                                                  bold: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DefaultPokemonText(
                                  text: 'MOVES',
                                  bold: true,
                                  color: PokemonColors.text.withOpacity(0.5),
                                  scale: 1.2,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: false,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _pokemon!.moves.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          color: PokemonColors.altAccent,
                                          elevation: 4,
                                          borderRadius: BorderRadius.circular(
                                              PokemonRadius
                                                  .defaultBorderRadius),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DefaultPokemonText(
                                                  text: _pokemon!
                                                      .moves[index].name
                                                      .toUpperCase(),
                                                  bold: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DefaultPokemonText(
                                  text: 'TYPE',
                                  bold: true,
                                  color: PokemonColors.text.withOpacity(0.5),
                                  scale: 1.2,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: false,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _pokemon!.types.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          color: PokemonColors.altText,
                                          elevation: 4,
                                          borderRadius: BorderRadius.circular(
                                              PokemonRadius
                                                  .defaultBorderRadius),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DefaultPokemonText(
                                                  text: _pokemon!
                                                      .types[index].name
                                                      .toUpperCase(),
                                                  color:
                                                      PokemonColors.background,
                                                  bold: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )
                        : const DefaultPokemonLoader())),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius:
                    BorderRadius.circular(PokemonRadius.defaultBorderRadius),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.chevron_left),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
