import 'dart:math';

import 'package:fascia/estensione_string.dart';
import 'package:flutter/material.dart';
import '../providers/paziente_provider.dart';

class PazienteTile extends StatefulWidget {
  final Paziente paziente;
  PazienteTile(this.paziente);

  @override
  _PazienteTileState createState() => _PazienteTileState();
}

class _PazienteTileState extends State<PazienteTile> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${widget.paziente.cognome} ${widget.paziente.nome}'),
            subtitle: Text('tel: ${widget.paziente.telefono}'),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              height: max(
                70 +
                    (widget.paziente.note != null
                        ? widget.paziente.note!.textHeight(
                            const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                            80,
                          )
                        : 0),
                70,
              ),
              child: ListView(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.paziente.indirizzo != null
                              ? widget.paziente.indirizzo!
                              : '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          widget.paziente.citta != null
                              ? widget.paziente.citta!
                              : '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ]),
                  Text(
                    widget.paziente.email != null ? widget.paziente.email! : '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  if (widget.paziente.note != null)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.paziente.note!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
