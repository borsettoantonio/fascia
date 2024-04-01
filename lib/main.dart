import 'package:flutter/material.dart';
import './sectorPainter.dart';
import 'package:touchable/touchable.dart';
import 'package:provider/provider.dart';
import './point_provider.dart';

import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:desktop_window/desktop_window.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    DesktopWindow.setWindowSize(const Size(500, 900));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FASCIA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fascia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Paziente>(
      create: (_) => Paziente(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(200.0),
          minScale: 0.01,
          maxScale: 2.6,
          //clipBehavior: Clip.none,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  color: Colors.black12,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  alignment: Alignment.center,
                  child: CanvasTouchDetector(
                      gesturesToOverride: const [GestureType.onTapDown],
                      builder: (context) {
                        return CustomPaint(
                          painter: SectorsPainter(
                              context: context,
                              onTap: (detail) async {
                                Provider.of<Paziente>(context, listen: false)
                                    .setPunto(await _showPopupMenu(
                                  context,
                                  (detail as TapDownDetails).localPosition,
                                  constraints.maxWidth / 14,
                                ));
                                //print(x);
                              }),
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                        );
                      }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // funzione che mostra un menu
  Future<List<int>?> _showPopupMenu(
    BuildContext context,
    Offset localPosition,
    double diametro,
  ) async {
    var paziente = Provider.of<Paziente>(context, listen: false);
    int seg = paziente.getSegment(localPosition, diametro);

    return await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        localPosition.dx,
        localPosition.dy,
        MediaQuery.of(context).size.width - localPosition.dx,
        MediaQuery.of(context).size.height - localPosition.dy,
      ),
      items: elementiMenu(
        context,
        paziente,
        seg,
      ),
      useRootNavigator: true,
      elevation: 8.0,
    );
  }

  PopupMenuItem<List<int>> creaElemento(
    BuildContext context,
    String testo,
    Color colore,
    bool settato,
    int seg,
    int punto,
    int sottoPunto,
  ) {
    return PopupMenuItem<List<int>>(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      height: 30,
      value: <int>[
        seg,
        punto,
        sottoPunto,
      ],
      child: Container(
        width: double.infinity,
        height: 25,
        decoration: BoxDecoration(
          color: settato ? colore : null,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: settato
            ? Text(testo)
            : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(testo),
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colore,
                  ),
                )
              ]),
      ),
      // onTap: () =>
      //     Provider.of<Paziente>(context, listen: false).toggleAttiviExt(seg, 2),
    );
  }

  List<PopupMenuItem<List<int>>> elementiMenu(
    BuildContext context,
    Paziente paziente,
    int seg,
  ) {
    String nomePunto = '';
    Color colorePunto;
    bool puntoAttivo;
    List<PopupMenuItem<List<int>>> listaElementi = [];

    for (int i = 0; i < 6; i++) {
      colorePunto = paziente.sectorColors[i];
      puntoAttivo = paziente.segmenti[seg].attiviExt[i];
      nomePunto = paziente.nomiPunti[i];
      listaElementi.add(creaElemento(
          context, nomePunto, colorePunto, puntoAttivo, seg, i, -1));
    }

    for (int i = 6; i < 10; i++) {
      var subPoint = paziente.getSubPoint()[seg ~/ 2];
      var nPunto = paziente.nomiPunti[i];
      for (int m = 1; m <= subPoint[i - 6]; m++) {
        colorePunto = paziente.sectorColors[i];
        puntoAttivo = paziente.segmenti[seg].attiviInt[i - 6][m - 1];
        if (subPoint[i - 6] > 1) {
          nomePunto = '$nPunto $m';
        } else {
          nomePunto = nPunto;
        }
        listaElementi.add(creaElemento(
            context, nomePunto, colorePunto, puntoAttivo, seg, i, m - 1));
      }
    }
    return listaElementi;
  }
}
