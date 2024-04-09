import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './paziente_provider.dart';

class Pazienti with ChangeNotifier {
  List<Paziente> lista = <Paziente>[
    Paziente(
      id: 1,
      cognome: 'Rossi',
      nome: 'Mario',
      telefono: '0425492561',
      indirizzo: 'via Roma 77',
      citta: 'Roma',
      email: 'rossimario@gmail.com',
      punti: Uint8List.fromList([
        127,
        146,
        3,
        1,
        2,
        3,
      ]),
    ),
    Paziente(
      id: 2,
      cognome: 'Rossini',
      nome: 'Giulio',
      telefono: '0425492561',
      indirizzo: 'via Roma 88',
      citta: 'Rovigo',
      email: 'rossimario@gmail.com',
      punti: Uint8List.fromList([
        1,
        2,
        3,
        1,
        2,
        3,
        ...[1, 1, 2],
        ...[3, 3, 1],
        ...[1, 1, 2],
        ...[3, 3, 1]
      ]),
    ),
  ];

  final int version = 1;
  Database? db;

  //    D:\prove_flutter_1\fascia\.dart_tool\sqflite_common_ffi\databases\pazienti.db
  //    /data/user/0/com.example.fascia/databases/pazienti.db

// versione con due tabelle
/*
  Future<Database?> _openDb() async {
    final nomeFile = join(
      await getDatabasesPath(),
      'pazienti.db',
    );
    db ??= await openDatabase(nomeFile, onCreate: (database, version) {
      database.execute(
          'CREATE TABLE Pazienti(id INTEGER PRIMARY KEY, cognome TEXT, nome TEXT,telefono TEXT,'
          'indirizzo TEXT, citta TEXT, email TEXT)');
      database.execute(
          'CREATE TABLE Punti(idPunti INTEGER PRIMARY KEY,punto1 INTEGER,  punto2 INTEGER, punto3 INTEGER,'
          'punto4 INTEGER, punto5 INTEGER, punto6 INTEGER, punto7 INTEGER, punto8 INTEGER, punto9 INTEGER, '
          'punto10 INTEGER, punto11 INTEGER, punto12 INTEGER, punto13 INTEGER, punto14 INTEGER, punto15 INTEGER, '
          'punto16 INTEGER, punto17 INTEGER, punto18 INTEGER, '
          'FOREIGN KEY(idPunti) REFERENCES Pazienti(id))');
    }, version: version);
    return db;
  }
*/

// versione con una tabella
  Future<Database?> _openDb() async {
    final nomeFile = join(
      await getDatabasesPath(),
      'pazienti.db',
    );
    db ??= await openDatabase(nomeFile, onCreate: (database, version) {
      database.execute(
          'CREATE TABLE Pazienti(id INTEGER PRIMARY KEY, cognome TEXT, nome TEXT,telefono TEXT,'
          'indirizzo TEXT, citta TEXT, email TEXT, blob punti)');
    }, version: version);
    return db;
  }

  List<Paziente> risultato = [];

  Future getPazientiByCognome(String cognome) async {
    Database? db = await _openDb();
    final List<Map<String, Object?>>? paz =
        await db?.query('Pazienti', where: 'cognome = "$cognome"');
    risultato = paz != null ? [for (var p in paz!) Paziente.mapToObj(p)] : [];
    risultato.add(lista[0]);
    notifyListeners();
  }
}
