import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './paziente_provider.dart';

class Pazienti with ChangeNotifier {
  final int version = 1;
  Database? db;
  List<Paziente> risultato =
      []; // risultato ricerca pazienti per lo screen di scelta del paziente
  List<Paziente> listaPazienti =
      []; // risultato ricerca pazienti per lo screen di gestione dei pazienti

  //    D:\prove_flutter_1\fascia\.dart_tool\sqflite_common_ffi\databases\pazienti.db
  //    /data/user/0/com.example.fascia/databases/pazienti.db

// versione con due tabelle
/*
  Future<Database?> openDb() async {
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
  Future<Database?> openDb() async {
    final nomeFile = join(
      await getDatabasesPath(),
      'pazienti.db',
    );
    db = await openDatabase(nomeFile, onCreate: (database, version) {
      database.execute(
          'CREATE TABLE Pazienti(id INTEGER PRIMARY KEY, cognome TEXT, nome TEXT,telefono TEXT,'
          'indirizzo TEXT, citta TEXT, email TEXT, punti blob, note TEXT )');
    }, version: version);
    return db;
  }

  Future<void> getPazientiByCognome(String cognome) async {
    risultato = await getPazByCognome(cognome);
    notifyListeners();
  }

  Future<void> listaPazientiByCognome(String cognome) async {
    listaPazienti = await getPazByCognome(cognome);
    notifyListeners();
  }

  Future<List<Paziente>> getPazByCognome(String cognome) async {
    Database? db = await openDb();
    final List<Map<String, Object?>>? paz = cognome == ''
        ? await db?.query(
            'Pazienti',
          )
        : await db?.query(
            'Pazienti',
            where: 'cognome LIKE "%$cognome%"',
          );
    await db!.close();
    return paz != null ? [for (var p in paz!) Paziente.mapToObj(p)] : [];
  }

  Future<Paziente?> getPazById(int id) async {
    Database? db = await openDb();
    final List<Map<String, Object?>>? paz = await db?.query(
      'Pazienti',
      where: 'id = $id',
    );
    await db!.close();
    return paz != null ? Paziente.mapToObj(paz[0]) : null;
  }

  Future<void> updatePuntiPazienteCorrente(
      int idCorrente, Uint8List punti) async {
    Map<String, Object> values = {'punti': punti};
    Database? db = await openDb();

    int? res = await db?.update(
      'Pazienti',
      values,
      where: 'id = ?',
      whereArgs: [idCorrente],
    );
    await db!.close();
    // aggiorno anche la variabile risultato
    for (final el in risultato) {
      if (el.id == idCorrente) {
        el.punti = punti;
        break;
      }
    }
  }

  Future<void> updatePaziente(Paziente paz) async {
    Map<String, Object?> values = paz.toMap();
    Database? db = await openDb();
    int? res = await db?.update(
      'Pazienti',
      values,
      where: 'id = ?',
      whereArgs: [paz.id],
    );
    await db!.close();
    // aggiorno anche la variabile listaPazienti
    for (int i = 0; i < listaPazienti.length; i++) {
      if (listaPazienti[i].id == paz.id) {
        listaPazienti[i] = paz;
        notifyListeners();
        break;
      }
    }

/*
    // aggiorno anche la variabile risultato
    for (int i = 0; i < risultato.length; i++) {
      if (risultato[i].id == paz.id) {
        risultato[i] = paz;
        //notifyListeners();
        break;
      }
    }

    notifyListeners();
*/
  }

  Future<void> addPaziente(Paziente paz) async {
    Map<String, Object?> values = paz.toMap();
    values['id'] = null;
    Database? db = await openDb();
    int? res = await db?.insert(
      'Pazienti',
      values,
    );
    await db!.close();
    // aggiorno anche la variabile listaPazienti
    paz.id = res!;
    listaPazienti.add(paz);
    notifyListeners();
  }

  Future<void> deletePaziente(Paziente paz) async {
    Database? db = await openDb();
    int? res = await db?.delete(
      'Pazienti',
      where: 'id = ?',
      whereArgs: [paz.id],
    );
    await db!.close();
    // aggiorno anche la variabile listaPazienti
    for (int i = 0; i < listaPazienti.length; i++) {
      if (listaPazienti[i].id == paz.id) {
        listaPazienti.removeAt(i);
        notifyListeners();
        break;
      }
    }
    // aggiorno anche la variabile risultato
    for (int i = 0; i < risultato.length; i++) {
      if (risultato[i].id == paz.id) {
        risultato.removeAt(i);
        // notifyListeners();
        break;
      }
    }
  }

  void resetPazienti() {
    listaPazienti = [];
    risultato = [];
    notifyListeners();
  }
}
