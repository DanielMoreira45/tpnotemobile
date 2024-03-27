import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> getdatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
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
      },
    );
  }
}
