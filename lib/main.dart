import 'package:flutter/material.dart';
import 'package:pokedex/shared/register_factory/register_factory.dart';
import 'shared/navigation/route_generator.dart';

void main() {
  //init our DI Factory
  RegisterFactory().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
          //set font
          ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
