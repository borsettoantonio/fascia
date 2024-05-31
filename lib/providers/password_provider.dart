import 'dart:convert';

import 'package:crypto/crypto.dart';

class Password {
  String _psw = encryptPassword('12345');
  String _pet = encryptPassword('fido');

  Password() {}

  static String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  String get psw => _psw;
  String get pet => _pet;
}
