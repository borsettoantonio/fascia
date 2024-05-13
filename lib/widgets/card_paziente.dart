import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/paziente_provider.dart';
import '../providers/point_provider.dart';
import './punti_screen.dart';

class CardPaziente extends StatelessWidget {
  const CardPaziente({
    super.key,
    required this.lista,
    required this.position,
  });

  final int position;
  final List<Paziente> lista;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(
          10,
        ),
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          title: Text('${lista[position].cognome} ${lista[position].nome}'),
          subtitle:
              Text('${lista[position].citta} tel: ${lista[position].telefono}'),
          onTap: () {
            Provider.of<PazienteCorrente>(context, listen: false)
                .setPazienteCorrente(lista[position]);
            Navigator.of(context)
                .pushNamed(PuntiScreen.routeName, arguments: lista[position]);
            //'${lista[position].cognome} ${lista[position].nome}');
          },
        ));
  }
}
