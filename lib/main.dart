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
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (int selectedValue) {
              print(selectedValue);
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('AN'), value: 0),
              const PopupMenuItem(child: Text('LA'), value: 1),
            ],
          )
        ],
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
                    gesturesToOverride: const [GestureType.onTapDown],
                    builder: (context) {
                      return CustomPaint(
                        painter: SectorsPainter(
                            context: context,
                            onTap: (color) {
                              setState(() {});
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
}
