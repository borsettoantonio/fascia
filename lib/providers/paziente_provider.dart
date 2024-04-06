import 'package:flutter/foundation.dart';

class Paziente with ChangeNotifier {
  int id;
  String cognome;
  String nome;
  String telefono;
  String indirizzo;
  String citta;
  String? email;

  Paziente({
    required this.id,
    required this.cognome,
    required this.nome,
    required this.telefono,
    required this.indirizzo,
    required this.citta,
    this.email,
  });
}
