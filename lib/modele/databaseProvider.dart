import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:tpnotemobile/modele/database.dart';

import 'modele.dart';

class ProviderDataBase {
  static ProviderDataBase? _dataBaseProvider;
  static late Database _database;

  static ProviderDataBase get dataBaseProvider {
    _dataBaseProvider ??= ProviderDataBase();
    return _dataBaseProvider!;
  }

  static Future<void> initProvider() async {
    _database = await DatabaseHelper.getdatabase();
  }

  static Future<NombreMagique> getNombreMagique() async {
    DatabaseHelper.updateBD;
    await initProvider();

    List<Map<String, dynamic>> result = await _database.query('NombreMagique');
    if (result.isNotEmpty) {
      List<Map<String, dynamic>> mutableList = List.from(result);
      mutableList.shuffle();
      int randomIndex = Random().nextInt(mutableList.length);
      var randomValue = mutableList[randomIndex];
      NombreMagique nombreMagique = NombreMagique(
        valeur: randomValue['valeur'],
        indiceFacile: randomValue['indiceFacile'],
        indiceMoyen: randomValue['indiceMoyen'],
        indiceDifficile: randomValue['indiceDifficile'],
      );
      return nombreMagique;
    } else {
      throw Exception("Aucun NombreMagique trouvé dans la base de données");
    }
  }

}
