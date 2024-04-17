import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/punti_screen.dart';
import 'package:provider/provider.dart';
import '../providers/pazienti_provider.dart';
import '../widgets/card_paziente.dart';
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
              onDismissed: (direction) {
                Provider.of<Pazienti>(context, listen: false)
                    .deletePaziente(item);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.cognome} eliminato')));
                setState(() {
                  listaPazienti.removeAt(index);
                });
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

      drawer: AppDrawer(),
    );
  }
}
