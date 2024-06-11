import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

import 'package:provider/provider.dart';
import '../providers/pazienti_provider.dart';

import '../widgets/paziente_tile.dart';
import './edit_paziente_screen.dart';

class GestionePazienteScreen extends StatefulWidget {
  const GestionePazienteScreen({super.key});

  static const routeName = '/GestionePaziente';
  final String title = 'Fascia';

  @override
  State<GestionePazienteScreen> createState() => GestionePazienteScreenState();
}

class GestionePazienteScreenState extends State<GestionePazienteScreen> {
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Gestione Pazienti');

  @override
  Widget build(BuildContext context) {
    var listaPazienti = Provider.of<Pazienti>(context).listaPazienti;
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
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    onSubmitted: (String text) {
                      Provider.of<Pazienti>(context, listen: false)
                          .listaPazientiByCognome(text);
                      setState(() {
                        visibleIcon = const Icon(Icons.search);
                        searchBar = const Text('Gestione Pazienti');
                      });
                    },
                  );
                  //
                } else {
                  setState(() {
                    visibleIcon = const Icon(Icons.search);
                    searchBar = const Text('Gestione Pazienti');
                  });
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditPazienteScreen.routeName);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: listaPazienti.length,
          itemBuilder: (context, index) {
            final item = listaPazienti[index];
            return Dismissible(
              key: Key(item.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete_forever,
                    color: Colors.white, size: 50.0),
              ),
              confirmDismiss: (direction) async {
                final bool res = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Confermi la cancellazione di ${item.cognome} ${item.nome}?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              "Annulla",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: const Text(
                              "Cancella",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Provider.of<Pazienti>(context, listen: false)
                                  .deletePaziente(item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('${item.cognome} eliminato')));
                              setState(() {
                                listaPazienti.removeAt(index);
                              });

                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    });
                return res;
              },
              child: Material(
                child: InkWell(
                  radius: 200,
                  child: PazienteTile(item),
                  onTap: () {
                    Navigator.pushNamed(context, EditPazienteScreen.routeName,
                        arguments: item);
                  },
                ),
              ),
            );
            //return PazienteTile(item);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 4.0);
          },
        ),
      ),

      /*  ListView.builder(
          itemCount: listaPazienti.length,
          itemBuilder: (BuildContext context, int position) =>
              CardPaziente(lista: listaPazienti, position: position)), */

      drawer: const AppDrawer(),
    );
  }
}
