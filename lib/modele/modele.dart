/// `NombreMagique` est une classe qui représente un nombre magique.
///
/// Il a une valeur et trois indices : facile, moyen et difficile.
class NombreMagique {
  final int _valeur;
  final String _indiceFacile;
  final String _indiceMoyen;
  final String _indiceDifficile;

  /// Crée une nouvelle instance de `NombreMagique`.
  ///
  /// Requiert :
  /// - `valeur` : la valeur du nombre magique.
  /// - `indiceFacile` : l'indice facile.
  /// - `indiceMoyen` : l'indice moyen.
  /// - `indiceDifficile` : l'indice difficile.
  const NombreMagique({
    required int valeur,
    required String indiceFacile,
    required String indiceMoyen,
    required String indiceDifficile,
  })  : _valeur = valeur,
        _indiceFacile = indiceFacile,
        _indiceMoyen = indiceMoyen,
        _indiceDifficile = indiceDifficile;

  int get valeur => _valeur;
  String get indiceFacile => _indiceFacile;
  String get indiceMoyen => _indiceMoyen;
  String get indiceDifficile => _indiceDifficile;

  /// Compare la `valeur` donnée avec la valeur du nombre magique.
  ///
  /// Renvoie :
  /// - `-1` si `valeur` est inférieure à la valeur du nombre magique.
  /// - `1` si `valeur` est supérieure à la valeur du nombre magique.
  /// - `0` si `valeur` est égale à la valeur du nombre magique.
  int compare(int valeur) {
    if (valeur < _valeur) {
      return -1;
    } else if (valeur > _valeur) {
      return 1;
    } else {
      return 0;
    }
  }
}
