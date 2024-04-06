import 'package:flutter/foundation.dart';

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
    ),
    Paziente(
      id: 2,
      cognome: 'Rossini',
      nome: 'Giulio',
      telefono: '0425492561',
      indirizzo: 'via Roma 88',
      citta: 'Rovigo',
      email: 'rossimario@gmail.com',
    ),
  ];

  List<Paziente> risultato = [];

  void getPazientiByCognome(String cognome) {
    risultato = lista
        .where((element) =>
            element.cognome.toLowerCase().contains(cognome.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
