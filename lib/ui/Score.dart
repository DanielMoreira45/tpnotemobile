import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tpnotemobile/modele/database.dart';



class ScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores Page'),
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _getHistoriqueParties(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final historiqueParties = snapshot.data!;
              return ListView.builder(
                itemCount: historiqueParties.length,
                itemBuilder: (context, index) {
                  final partie = historiqueParties[index];
                  return ListTile(
                    title: Text('Nombre Magique ID: ${partie['nombreMagique_id']}'),
                    subtitle: Text('Tentative: ${partie['tentative']}, Réussie: ${partie['tentative_reussie']}'),
                    // Affichez d'autres données au besoin
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Une erreur est survenue : ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
  Future<List<Map<String, dynamic>>> _getHistoriqueParties() async {
    final Database db = await DatabaseHelper.getdatabase();
    Future<List<Map<String, dynamic>>> requete = db.query('NombreMagique');
    return db.query('HistoriqueParties');
  }
}
