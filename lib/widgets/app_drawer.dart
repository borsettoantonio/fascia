import 'package:fascia/screens/database_screen.dart';
import 'package:fascia/screens/gestione_password_screen.dart';
import 'package:flutter/material.dart';
import '../screens/cerca_paziente_screen.dart';
import '../screens/gestione_pazienti_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Fascia'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person_search),
            title: const Text('Scegli paziente'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CercaPazienteScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Gestione pazienti'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(GestionePazienteScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gestione password'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(GestionePasswordScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.save),
            title: const Text('Import/Export database'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(DatabaseScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
