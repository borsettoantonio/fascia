import 'package:flutter/material.dart';
import '../screens/cerca_paziente_screen.dart';
import '../screens/gestione_pazienti_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Fascia'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.person_search),
            title: Text('Scegli paziente'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CercaPazienteScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Gestione pazienti'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(GestionePazienteScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gestione password'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/paziente');
            },
          ),
        ],
      ),
    );
  }
}
