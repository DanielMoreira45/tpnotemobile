import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> getdatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'ma_bd.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE NombreMagique (
              id INTEGER PRIMARY KEY,
              valeur INTEGER NOT NULL,
              indiceFacile TEXT,
              indiceMoyen TEXT,
              indiceDifficile TEXT
          );

          CREATE TABLE HistoriqueParties (
              id INTEGER PRIMARY KEY,
              nombreMagique_id INTEGER,
              tentative INTEGER,
              tentative_reussie INTEGER,
              date_partie TEXT DEFAULT CURRENT_TIMESTAMP,
              FOREIGN KEY (nombreMagique_id) REFERENCES NombreMagique(id)
          )
          ''');

        List<Map<String, dynamic>> nombreMagiqueEntries = [
          {
            'valeur': 42,
            'indiceFacile': 'C\'est un nombre pair',
            'indiceMoyen': 'C\'est un multiple de 6',
            'indiceDifficile': 'C\'est la réponse à la vie, l\'univers et le reste'
          },
          {
            'valeur': 17,
            'indiceFacile': 'Il est premier',
            'indiceMoyen': 'Il est un nombre de Fermat',
            'indiceDifficile': 'Il est la somme de deux carrés',
          },
          {
            'valeur': 144,
            'indiceFacile': 'Il est un carré parfait',
            'indiceMoyen': 'Il est le carré d\'un nombre entier',
            'indiceDifficile': 'Il est divisible par 12',
          },
          {
            'valeur': 99,
            'indiceFacile': 'Il est divisible par 9',
            'indiceMoyen': 'La somme de ses chiffres est égale à 18',
            'indiceDifficile': 'Il est un multiple de 11',
          },
        ];

        for (var entry in nombreMagiqueEntries) {
          await db.insert('NombreMagique', entry);
        }
      },
    );
  }

  static void deleteBd(){

  }
}
