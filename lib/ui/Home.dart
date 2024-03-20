import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/jouer');
                },
                child: const Text('Jouer'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/scores');
                },
                child: const Text('Voir les scores'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/regles');
                },
                child: const Text('Regles du jeu'),
              )
            ],
          )
      ),
    );
  }



}