import 'package:fascia/providers/password_provider.dart';
import 'package:fascia/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onStart();
  }

  Future<void> onStart() async {
    await Provider.of<Password>(context, listen: false).init();
    await Future.delayed(const Duration(milliseconds: 1000));
    await Navigator.pushReplacementNamed(context, AuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          //backgroundBlendMode: BlendMode.plus,
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(215, 117, 255, 1), //.withOpacity(0.5),
              Color.fromRGBO(255, 188, 117, 1), //.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
      ),
      Center(
        child: Image.asset('assets/icon_fascia.png'),
      ),
    ]);
  }
}
