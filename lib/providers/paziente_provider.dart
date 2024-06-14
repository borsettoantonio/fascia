import 'package:flutter/foundation.dart';

class Paziente with ChangeNotifier {
  int id;
  String cognome;
  String nome;
  String? telefono;
  String? indirizzo;
  String? citta;
  String? email;
  Uint8List punti; // 4 bytes  per 32 segmanti
  String? note;

  Paziente({
    required this.id,
    required this.cognome,
    required this.nome,
    this.telefono,
    this.indirizzo,
    this.citta,
    this.email,
    required this.punti,
    this.note,
  });

  static Paziente mapToObj(Map<String, Object?> p) {
    return Paziente(
      id: p['id']! as int,
      cognome: p['cognome']! as String,
      nome: p['nome']! as String,
      telefono: p['telefono'] as String?,
      indirizzo: p['indirizzo'] as String?,
      citta: p['citta'] as String?,
      email: p['email'] as String?,
      punti: p['punti']! as Uint8List,
      note: p['note'] as String?,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'cognome': cognome,
      'nome': nome,
      'telefono': telefono,
      'indirizzo': indirizzo,
      'citta': citta,
      'email': email,
      'punti': punti,
      'note': note,
    };
  }
}
