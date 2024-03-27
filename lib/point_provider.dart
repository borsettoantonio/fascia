import 'package:flutter/material.dart';

class Paziente with ChangeNotifier {
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
    [1, 2, 3, 1], // RE LA , RE ME, AN ME, AN LA  per segmento 'CP1',
    [1, 2, 3, 1], // ...                          per segmento 'CP2',
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [1, 2, 3, 1],
    [2, 2, 2, 2],
    [1, 1, 1, 1],
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
  Paziente() {
    for (int i = 0; i < 32; i++) {
      segmenti.add(Segmento());
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
  Offset posizione = Offset(0.0, 0.0); // centro del cerchio
}
