import 'package:fascia/providers/password_provider.dart';
import 'package:fascia/screens/cerca_paziente_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef MapCallback = void Function(bool psw);

// ignore: must_be_immutable
class PasswordCard extends StatefulWidget {
  PasswordCard(this.cambia, {super.key});
  //Function(bool psw) cambia;
  final MapCallback cambia;

  @override
  PasswordCardState createState() => PasswordCardState();
}

class PasswordCardState extends State<PasswordCard> {
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'password': '',
  };

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    if (_authData['password'] !=
        Provider.of<Password>(context, listen: false).psw) {
      _showErrorDialog('Password errata!');
    } else {
      Navigator.of(context).pushReplacementNamed(CercaPazienteScreen.routeName);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
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
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password troppo corta!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = Password.encryptPassword(value!);
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
                  onPressed: () => widget.cambia(false),
                  child: const Text('Password dimenticata?'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
