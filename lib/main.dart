import 'package:flutter/material.dart';
import './sectorPainter.dart';
import 'package:touchable/touchable.dart';

void main() {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(200.0),
        minScale: 0.01,
        maxScale: 2.6,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                //color: Colors.black12,
                //height: 350,
                //width: 350,
                alignment: Alignment.center,
                child: CanvasTouchDetector(
                    gesturesToOverride: const [GestureType.onTapUp],
                    builder: (context) {
                      return CustomPaint(
                        painter: SectorsPainter(
                            context: context,
                            onTap: (detail) {
                              //setState(() {});
                              _showPopupMenu(
                                  (detail as TapUpDetails).globalPosition);
                            }),
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }

  // funzione che mostra un menu
  void _showPopupMenu(Offset globalPosition) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        globalPosition.dx,
        globalPosition.dy,
        MediaQuery.of(context).size.width - globalPosition.dx,
        MediaQuery.of(context).size.height - globalPosition.dy,
      ),
      items: [
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade700,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('secondo'),
          ),
        ),
        PopupMenuItem<String>(
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              //color: Colors.greenAccent.shade700,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('terzo'),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  )
                ]),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          height: 30,
          value: 'Doge',
          child: Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Text('primo'),
          ),
        ),
      ],
      useRootNavigator: true,
      elevation: 8.0,
    );
  }
}
