import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/point_provider.dart';
import 'providers/pazienti_provider.dart';
import 'widgets/punti_screen.dart';
import './screens/auth_screen.dart';
import './screens/cerca_paziente_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PazienteCorrente()),
        ChangeNotifierProvider(create: (_) => Pazienti()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FASCIA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthScreen(),
        routes: {
          PuntiScreen.routeName: (ctx) => PuntiScreen(),
          CercaPazienteScreen.routeName: (ctx) => CercaPazienteScreen(),
        },
      ),
    );
  }
}
