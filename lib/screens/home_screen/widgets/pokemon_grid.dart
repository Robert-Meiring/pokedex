import 'package:flutter/material.dart';
import 'package:pokedex/shared/logic/features/pokemon/entities/pokemon_small.dart';
import 'package:pokedex/shared/styling/pokemon_styling.dart';
import 'package:pokedex/shared/widgets/text/pokemon_text.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonGrid extends StatelessWidget {
  PokemonGrid({Key? key, required this.list}) : super(key: key);

  final List<PokemonSmall> list;

  final ScrollController _controller = ScrollController();

  //Basic GridviewBuilder displaying a networkimage alongside the name of our pokemon enitity contained in the list
  //When an item is selected, navigate to the individual pokemon screen using named routes and pass relevant arguments with it

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controller,
      interactive: true,
      thickness: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
            cacheExtent: 50,
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Material(
                  color: PokemonColors.altText.withOpacity(0.2),
                  elevation: 0,
                  borderRadius:
                      BorderRadius.circular(PokemonRadius.defaultBorderRadius),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/pokemonview',
                          arguments: list[index].url);
                    },
                    borderRadius: BorderRadius.circular(
                        PokemonRadius.defaultBorderRadius),
                    splashColor: PokemonColors.altAccent,
                    highlightColor: PokemonColors.altAccent.withOpacity(0.5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultPokemonText(
                            text: list[index].name.toUpperCase(),
                            bold: true,
                            color: PokemonColors.altText,
                          ),
                        ),
                        Expanded(
                          child: FadeInImage.memoryNetwork(
                            image: list[index].imageUrl,
                            placeholder: kTransparentImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
