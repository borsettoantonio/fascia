import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/punti_screen.dart';
import 'package:provider/provider.dart';
import '../providers/pazienti_provider.dart';
import '../widgets/card_paziente.dart';

class CercaPazienteScreen extends StatefulWidget {
  const CercaPazienteScreen({super.key});

  static const routeName = '/paziente';
  final String title = 'Fascia';

  @override
  State<CercaPazienteScreen> createState() => CercaPazienteScreenState();
}

class CercaPazienteScreenState extends State<CercaPazienteScreen> {
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Paziente');

  @override
  Widget build(BuildContext context) {
    var listaPazienti = Provider.of<Pazienti>(context).risultato;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: searchBar,
        actions: <Widget>[
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = const Icon(Icons.cancel);
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    onSubmitted: (String text) {
                      Provider.of<Pazienti>(context, listen: false)
                          .getPazientiByCognome(text);
                      setState(() {
                        visibleIcon = const Icon(Icons.search);
                        searchBar = const Text('Paziente');
                      });
                    },
                  );
                } else {
                  setState(() {
                    visibleIcon = const Icon(Icons.search);
                    searchBar = const Text('Paziente');
                  });
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: listaPazienti.length,
          itemBuilder: (BuildContext context, int position) =>
              CardPaziente(lista: listaPazienti, position: position)),
      drawer: AppDrawer(),
    );
  }
}
