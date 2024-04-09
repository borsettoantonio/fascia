import 'package:flutter/material.dart';
import './paziente_provider.dart';

class PazienteCorrente with ChangeNotifier {
  static final List<String> _segName = [
    'CP1',
    'CP2',
    'CP3',
    'CL',
    'TH',
    'LU',
    'PV',
    'SC',
    'HU',
    'CU',
    'CA',
    'DI',
    'CX',
    'GE',
    'TA',
    'PE',
  ];

  static final List<List<int>> _subPoint = [
    [1, 1, 1, 1], // RE LA , RE ME, AN ME, AN LA  per segmento 'CP1',
    [1, 1, 1, 1], // ...                          per segmento 'CP2',
    [1, 1, 1, 1], // CP3
    [1, 1, 1, 1], // CL
    [1, 3, 3, 2], // TH
    [1, 3, 3, 3], // LU
    [2, 2, 3, 3], // PV
    [2, 2, 2, 2], // SC
    [1, 1, 1, 1], // HU
    [2, 2, 2, 2], // CU
    [2, 2, 2, 2], // CA
    [2, 2, 2, 2], // DI
    [1, 1, 1, 1], // CX
    [2, 2, 3, 3], // GE
    [2, 2, 2, 2], // TA
    [3, 3, 3, 3], // PE
  ];

  List<String> nomiPunti = [
    'AN',
    'LA',
    'ER',
    'RE',
    'ME',
    'IR',
    'RE LA',
    'RE ME',
    'AN ME',
    'AN LA',
  ];

  List<Color> sectorColors = [
    Colors.redAccent,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.amber
  ];

  List<Segmento> segmenti = [];

  // costruttore
  PazienteCorrente([Paziente? paz]) {
    for (int i = 0; i < 32; i++) {
      segmenti.add(Segmento());
    }
  }

  void setPazienteCorrente(Paziente paz) {
    int k = 0; // indice nei bytes del blob
    for (int s = 0; s < 2; s++) {
      // elaboro i 32 segmenti
      int mask = 1;
      for (int j = 0; j < 6; j++) {
        //elaboro i 6 punti esterni
        segmenti[s].attiviExt[j] = (paz.punti[k] & mask) == 0 ? false : true;
        mask <<= 1;
      }
      for (int j = 0; j < 4; j++) {
        //elaboro i 4 punti interni
        for (int e = 0; e < 3; e++) {
          //elaboro i max 3 sottopunti punti interni
          segmenti[s].attiviInt[j][e] =
              (paz.punti[k] & mask) == 0 ? false : true;
          mask <<= 1;
          if (mask == 256) {
            mask = 1;
            k++;
          }
        }
      }
      k++;
    }
  }

  List<String> getSegmentName() {
    return [..._segName];
  }

  List<List<int>> getSubPoint() {
    return [..._subPoint];
  }

  void toggleAttiviExt(int seg, int index) {
    segmenti[seg].attiviExt[index] =
        segmenti[seg].attiviExt[index] ? false : true;
    notifyListeners();
  }

  int getSegment(Offset localPosition, double diametro) {
    //print('-------');
    //print(localPosition);
    //print('diametro $diametro');

    double quadratoDiametro = diametro * diametro;
    for (int i = 0; i < segmenti.length; i++) {
      //print('segmento $i');
      //print(segmenti[i].posizione.dx);
      //print(segmenti[i].posizione.dy);

      double quadratoDistanza = (localPosition.dx - segmenti[i].posizione.dx) *
              (localPosition.dx - segmenti[i].posizione.dx) +
          (localPosition.dy - segmenti[i].posizione.dy) *
              (localPosition.dy - segmenti[i].posizione.dy);
      if (quadratoDistanza < quadratoDiametro) return i;
    }
    return -1;
  }

  void setPunto(List<int>? dati) {
    if (dati == null) return;
    if (dati![2] == -1) // punti della corona esterna
    {
      segmenti[dati[0]].attiviExt[dati[1]] =
          !segmenti[dati[0]].attiviExt[dati[1]];
    } else //punti della corona interna
    {
      segmenti[dati[0]].attiviInt[dati[1] - 6][dati[2]] =
          !segmenti[dati[0]].attiviInt[dati[1] - 6][dati[2]];
    }
    notifyListeners();
  }
}

class Segmento {
  List<bool> attiviExt = [false, false, false, false, false, false];
  List<List<bool>> attiviInt = [
    [false, false, false],
    [false, false, false],
    [false, false, false],
    [false, false, false],
  ];
  Offset posizione = const Offset(0.0, 0.0); // centro del cerchio
}