import 'package:flutter/foundation.dart';

class Paziente with ChangeNotifier {
  int id;
  String cognome;
  String nome;
  String? telefono;
  String? indirizzo;
  String? citta;
  String? email;
  Uint8List punti; // 3 bytes (con massimo 12 punti) per 32 segmanti

  Paziente({
    required this.id,
    required this.cognome,
    required this.nome,
    required this.telefono,
    required this.indirizzo,
    required this.citta,
    this.email,
    required this.punti,
  });

  static Paziente mapToObj(Map<String, Object?> p) {
    return Paziente(
      id: p['id']! as int,
      cognome: p['cognome']! as String,
      nome: p['nome']! as String,
      telefono: p['telefono']! as String,
      indirizzo: p['indirizzo']! as String,
      citta: p['citta']! as String,
      email: p['email']! as String,
      punti: p['email']! as Uint8List,
    );
  }
}
