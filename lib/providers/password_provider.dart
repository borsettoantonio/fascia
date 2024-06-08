import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fascia/providers/pazienti_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class Password {
  String _psw = encryptPassword('12345');
  String _pet = encryptPassword('fido');
  BuildContext ctx;

  Password(this.ctx);

  Future<void> init() async {
    Database? db = await Provider.of<Pazienti>(ctx, listen: false).openDb();
    final nomeFile = join(
      await getDatabasesPath(),
      'pazienti.db',
    );
    db = await openDatabase(nomeFile);
    final res = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: ['Password']);
    if (res.isEmpty) {
      db.execute('CREATE TABLE Password(password TEXT, pet TEXT)');
      db.insert('Password', {'password': _psw, 'pet': _pet});
    }
    final data = await db.query('Password');
    await db.close();
    _psw = data[0]['password'] as String;
    _pet = data[0]['pet'] as String;
  }

  Future<int> setPassword(String psw, String pet,
      [bool encripted = false]) async {
    if (!encripted) {
      psw = encryptPassword(psw);
      pet = encryptPassword(pet);
    }
    Database? db = await Provider.of<Pazienti>(ctx, listen: false).openDb();
    final nomeFile = join(
      await getDatabasesPath(),
      'pazienti.db',
    );
    db = await openDatabase(nomeFile);
    int num;

    num = await db.update(
      'Password',
      {'password': psw, 'pet': pet},
    );

    await db.close();

    // controllo se ci sono errori
    if (num == 0) {
      return 0;
    } else {
      _psw = psw;
      _pet = pet;
      return num;
    }
  }

  Future<int> aggiornaPassword() async {
    return await setPassword(_psw, _pet, true);
  }

  static String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  String get psw => _psw;
  String get pet => _pet;
}
