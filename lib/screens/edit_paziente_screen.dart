import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pazienti_provider.dart';
import '../providers/paziente_provider.dart';

class EditPazienteScreen extends StatefulWidget {
  static const routeName = '/edit-paziente';
  final Paziente? paz;

  const EditPazienteScreen({super.key, this.paz});

  @override
  State<EditPazienteScreen> createState() => _EditPazienteScreenState();
}

class _EditPazienteScreenState extends State<EditPazienteScreen> {
  final _nomeFocusNode = FocusNode();
  final _telefonoFocusNode = FocusNode();
  final _indirizzoFocusNode = FocusNode();
  final _cittaFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _noteFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  Paziente _editedPaz = Paziente(
    id: 0,
    cognome: '',
    nome: '',
    telefono: '',
    indirizzo: '',
    citta: '',
    email: '',
    punti: Uint8List(0),
    note: '',
  );

  Map<String, String?> _initValues = {
    'cognome': '',
    'nome': '',
    'telefono': null,
    'indirizzo': null,
    'citta': null,
    'email': null,
    'note': ''
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    Paziente? p;
    _isLoading = true;
    if (_isInit) {
      if (widget.paz != null) {
        p = await Provider.of<Pazienti>(context, listen: false)
            .getPazById(widget.paz!.id);
      } else {
        var arg = ModalRoute.of(context)!.settings.arguments as Paziente?;
        if (arg != null) {
          p = arg;
        }
      }
      if (p != null) {
        _editedPaz = p;
        _initValues = {
          'cognome': _editedPaz.cognome,
          'nome': _editedPaz.nome,
          'telefono': _editedPaz.telefono,
          'indirizzo': _editedPaz.indirizzo,
          'citta': _editedPaz.citta,
          'email': _editedPaz.email,
          'note': _editedPaz.note,
        };
      } else {
        _editedPaz = Paziente(
          id: 0,
          cognome: '',
          nome: '',
          telefono: '',
          indirizzo: '',
          citta: '',
          email: '',
          punti: Uint8List(0),
          note: '',
        );
      }
    }

    _isInit = false;
    setState(() {
      _isLoading = false;
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nomeFocusNode.dispose();
    _telefonoFocusNode.dispose();
    _indirizzoFocusNode.dispose();
    _cittaFocusNode.dispose();
    _emailFocusNode.dispose();
    _noteFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    if ((_editedPaz.id) != 0) {
      Provider.of<Pazienti>(context, listen: false).updatePaziente(_editedPaz);
    } else {
      try {
        Provider.of<Pazienti>(context, listen: false).addPaziente(_editedPaz);
      } catch (error) {
        //   !!!!!!! ATTENZIONE !!!!!!!!!
        // con return showDialog<void>(
        // oppure
        // return showDialog(
        // il successivo then non viene eseguito  !!!!!!!
        // !!!!!  NON SO PERCHE'
        showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred'),
            content: const Text('Something went wrong!'),
            actions: <Widget>[
              TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    if (widget.paz == null) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: _editedPaz.id != 0
            ? const Text('Modifica Paziente')
            : const Text('Crea Paziente'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['cognome'],
                      decoration: const InputDecoration(labelText: 'Cognome'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_nomeFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Si prega di fornire un cognome';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPaz = Paziente(
                          id: _editedPaz.id,
                          cognome: value!,
                          nome: _editedPaz.nome,
                          telefono: _editedPaz.telefono,
                          indirizzo: _editedPaz.indirizzo,
                          citta: _editedPaz.citta,
                          email: _editedPaz.email,
                          punti: _editedPaz.punti,
                          note: _editedPaz.note,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['nome'],
                      decoration: const InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      focusNode: _nomeFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_telefonoFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Si prega di fornire un nome';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPaz = Paziente(
                          id: _editedPaz.id,
                          cognome: _editedPaz.cognome,
                          nome: value!,
                          telefono: _editedPaz.telefono,
                          indirizzo: _editedPaz.indirizzo,
                          citta: _editedPaz.citta,
                          email: _editedPaz.email,
                          punti: _editedPaz.punti,
                          note: _editedPaz.note,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['telefono'],
                      decoration: const InputDecoration(labelText: 'Telefono'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _telefonoFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_indirizzoFocusNode);
                      },
                      onSaved: (value) {
                        _editedPaz = Paziente(
                          id: _editedPaz.id,
                          cognome: _editedPaz.cognome,
                          nome: _editedPaz.nome,
                          telefono: value!,
                          indirizzo: _editedPaz.indirizzo,
                          citta: _editedPaz.citta,
                          email: _editedPaz.email,
                          punti: _editedPaz.punti,
                          note: _editedPaz.note,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['indirizzo'],
                      decoration: const InputDecoration(labelText: 'Indirizzo'),
                      textInputAction: TextInputAction.next,
                      focusNode: _indirizzoFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_cittaFocusNode);
                      },
                      onSaved: (value) {
                        _editedPaz = Paziente(
                          id: _editedPaz.id,
                          cognome: _editedPaz.cognome,
                          nome: _editedPaz.nome,
                          telefono: _editedPaz.telefono,
                          indirizzo: value!,
                          citta: _editedPaz.citta,
                          email: _editedPaz.email,
                          punti: _editedPaz.punti,
                          note: _editedPaz.note,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['citta'],
                      decoration: const InputDecoration(labelText: 'Città'),
                      textInputAction: TextInputAction.next,
                      focusNode: _cittaFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      onSaved: (value) {
                        _editedPaz = Paziente(
                          id: _editedPaz.id,
                          cognome: _editedPaz.cognome,
                          nome: _editedPaz.nome,
                          telefono: _editedPaz.telefono,
                          indirizzo: _editedPaz.indirizzo,
                          citta: value!,
                          email: _editedPaz.email,
                          punti: _editedPaz.punti,
                          note: _editedPaz.note,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['email'],
                      decoration: const InputDecoration(labelText: 'e-mail'),
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_noteFocusNode);
                      },
                      onSaved: (value) {
                        _editedPaz = Paziente(
                          id: _editedPaz.id,
                          cognome: _editedPaz.cognome,
                          nome: _editedPaz.nome,
                          telefono: _editedPaz.telefono,
                          indirizzo: _editedPaz.indirizzo,
                          citta: _editedPaz.citta,
                          email: value!,
                          punti: _editedPaz.punti,
                          note: _editedPaz.note,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['note'],
                      decoration: const InputDecoration(labelText: 'Note'),
                      focusNode: _noteFocusNode,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _editedPaz = Paziente(
                          id: _editedPaz.id,
                          cognome: _editedPaz.cognome,
                          nome: _editedPaz.nome,
                          telefono: _editedPaz.telefono,
                          indirizzo: _editedPaz.indirizzo,
                          citta: _editedPaz.citta,
                          email: _editedPaz.email,
                          punti: _editedPaz.punti,
                          note: value!,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
