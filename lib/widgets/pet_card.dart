import 'package:fascia/providers/password_provider.dart';
import 'package:fascia/screens/cerca_paziente_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetCard extends StatefulWidget {
  const PetCard(this.cambia, {super.key});
  final Function(bool psw) cambia;

  @override
  PetCardState createState() => PetCardState();
}

class PetCardState extends State<PetCard> {
  final _petController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'pet': '',
  };

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    if (_authData['pet'] != Provider.of<Password>(context, listen: false).pet) {
      _showErrorDialog('Nome errato!');
    } else {
      Navigator.of(context).pushReplacementNamed(CercaPazienteScreen.routeName);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Si è verificato un errore!'),
        content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    //final _passw = Provider.of<Password>(context,listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: 300,
        constraints: const BoxConstraints(minHeight: 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Il nome del tuo primo animaletto'),
                      labelStyle: TextStyle(overflow: TextOverflow.visible)),
                  obscureText: true,
                  controller: _petController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Inserire il nome';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['pet'] = Password.encryptPassword(value!);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => _submit(context),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8.0),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () => widget.cambia(true),
                  child: const Text('Annulla'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
