import 'package:flutter/material.dart';
import 'package:tpnotemobile/modele/modele.dart';
import '../modele/databaseProvider.dart';

class JouerPage extends StatefulWidget {
  const JouerPage({super.key});

  @override
  State<JouerPage> createState() => _JouerPageState();
}

class _JouerPageState extends State<JouerPage> {
  int? _difficulte;
  int _essaisRestants = -1;
  bool _gagne = false;
  late Future<NombreMagique> _futureNombreMagique;
  final TextEditingController _essaisController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureNombreMagique = ProviderDataBase.getNombreMagique();
    initEssaieMax();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NombreMagique>(
      future: _futureNombreMagique,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          NombreMagique nombreMagique = snapshot.data!;
          return _buildJouerPage(nombreMagique);
        }
      },
    );
  }

  Widget _buildJouerPage(NombreMagique nombreMagique) {
    if (_difficulte == null) {
      return pageChoixDifficulte();
    } else if (_essaisRestants == 0) {
      return pagePerdu();
    } else if (_gagne == true){
      return pageGagnee(nombreMagique);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Jouer'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Difficulté : ${_difficulte == 1 ? 'Facile' : (_difficulte == 2 ? 'Moyen' : 'Difficile')}'),
              Text('Essais restants : $_essaisRestants'),
              Text('Nombre magique : ${nombreMagique.valeur}'),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Indice : ',
                      style: TextStyle(color: Colors.black),
                    ),
                    if (_difficulte == 1) ...[
                      TextSpan(
                        text: '${nombreMagique.indiceFacile} \n',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text: '${nombreMagique.indiceMoyen} \n',
                        style: const TextStyle(color: Colors.green),
                      ),
                      TextSpan(
                        text: nombreMagique.indiceDifficile,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ] else if (_difficulte == 2) ...[
                      TextSpan(
                        text: '${nombreMagique.indiceMoyen} \n',
                        style: const TextStyle(color: Colors.green),
                      ),
                      TextSpan(
                        text: nombreMagique.indiceDifficile,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ] else ...[
                      TextSpan(
                        text: nombreMagique.indiceDifficile,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(
                width: 200, // Adjust the width as needed
                child: TextField(
                  controller: _essaisController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Un Nombre a essayée'),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  int? essai = int.tryParse(_essaisController.text);
                  if (essai != null) {
                    int res = nombreMagique.compare(essai);
                    switch (res) {
                      case -1:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Le nombre magique est plus grand.'),
                          ),
                        );
                        setState(() {
                          _essaisRestants--;
                        });
                        _essaisController.clear();
                        break;
                      case 1:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Le nombre magique est plus petit.'),
                          ),
                        );
                        setState(() {
                          _essaisRestants--;
                        });
                        _essaisController.clear();
                        break;
                      case 0:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bravo, vous avez trouvé le nombre magique !'),
                          ),
                        );
                        setState((){
                          _gagne = true;
                        });
                        break;
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez saisir un nombre entier.'),
                      ),
                    );
                  }
                },
                child: const Text('Valider'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _difficulte = null;
                    _essaisController.clear();
                  });
                },
                child: const Text('Changer de difficulté'),
              )
            ],
          ),
        ),
      );
    }
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

  Scaffold pageChoixDifficulte() {
    _futureNombreMagique = ProviderDataBase.getNombreMagique();
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

  Scaffold pagePerdu() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perdu'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Vous avez perdu'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _difficulte = null;
                  _essaisController.clear();
                });
              },
              child: const Text('Rejouer'),
            )
          ],
        ),
      ),
    );
  }

  Scaffold pageGagnee(NombreMagique nombreMagique) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gagné'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Bravo, vous avez trouvé le nombre magique !'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _difficulte = null;
                  _gagne = false;
                  _essaisController.clear();

                  ajouterPartieHistorique(nombreMagique.valeur, 10 - _essaisRestants, 1);
                });
              },
              child: const Text('Rejouer'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _essaisController.dispose();
    super.dispose();
  }

  void ajouterPartieHistorique(int nombreMagiqueId, int tentative, int tentativeReussie) {
    ProviderDataBase.ajouterPartieHistorique(nombreMagiqueId, tentative, tentativeReussie);
  }
}
