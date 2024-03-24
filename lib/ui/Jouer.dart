import 'package:flutter/material.dart';

class JouerPage extends StatefulWidget {
  const JouerPage({super.key});

  @override
  State<JouerPage> createState() => _JouerPageState();
}

class _JouerPageState extends State<JouerPage> {
  int? _difficulte;
  int _essaisRestants = -1;

  @override
  void initState() {
    super.initState();
    if (_difficulte == null) {
      _essaisRestants = -1;
    } else {
      initEssaieMax();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_difficulte == null) {
      return pageChoixDifficulte();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jouer'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Difficulté : $_difficulte'),
            Text('Essais restants : $_essaisRestants'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _essaisRestants--;
                });
              },
              child: const Text('Essayer'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _difficulte = null; // Réinitialiser la difficulté
                });
              },
              child: const Text('Changer de difficulté'),
            )
          ],
        ),
      ),
    );
  }

  void initEssaieMax() {
    // Initialisation des essais max en fonction de la difficulté
    if (_difficulte == 3) {
      _essaisRestants = 3;
    } else if (_difficulte == 2) {
      _essaisRestants = 5;
    } else {
      _essaisRestants = 10;
    }
  }

  Widget pageChoixDifficulte() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choix de la difficulté'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _difficulte = 1;
                  initEssaieMax();
                });
              },
              child: const Text('Facile'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _difficulte = 2;
                  initEssaieMax();
                });
              },
              child: const Text('Moyen'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _difficulte = 3;
                  initEssaieMax();
                });
              },
              child: const Text('Difficile'),
            )
          ],
        ),
      ),
    );
  }
}
