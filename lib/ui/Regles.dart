import 'package:flutter/material.dart';

class ReglePage extends StatelessWidget {
  const ReglePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Règles du jeu'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Règles du jeu'),
                SizedBox(height: 10),
                Text('Le but du jeu est de trouver le nombre mystère en un minimum de coups.'),
                SizedBox(height: 10),
                Text('Pour cela, vous devez proposer des nombres.'),
                SizedBox(height: 10),
                Text('A chaque proposition, le jeu vous indique si le nombre mystère est plus grand ou plus petit que votre proposition.'),
                SizedBox(height: 10),
                Text('Bonne chance !'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
