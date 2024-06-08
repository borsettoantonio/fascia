import 'package:flutter/material.dart';
import 'package:fascia/providers/password_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

class GestionePasswordScreen extends StatefulWidget {
  const GestionePasswordScreen({super.key});

  static const routeName = '/password';

  @override
  State<GestionePasswordScreen> createState() => _GestionePasswordScreenState();
}

class _GestionePasswordScreenState extends State<GestionePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  //final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'password': '',
    'ripetiPassword': '',
    'pet': '',
    'ripetiPet': '',
  };

  bool attendi = false;

  void _showErrorDialog(String titolo, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titolo),
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

  Future<void> _submit(BuildContext context) async {
    setState(() {
      attendi = true;
    });

    if (!_formKey.currentState!.validate()) {
      // Invalid!
    } else {
      _formKey.currentState!.save();

      if (_authData['password'] != _authData['ripetiPassword']) {
        _showErrorDialog(
            'Si è verificato un errore!', 'Le password non sono uguali');
      } else if (_authData['pet'] != _authData['ripetiPet']) {
        _showErrorDialog(
            'Si è verificato un errore!', 'I nomi non sono uguali');
      } else {
        int numModificati = await Provider.of<Password>(context, listen: false)
            .setPassword(_authData['password']!, _authData['pet']!);
        if (numModificati == 0) // errore sul database
        {
          _showErrorDialog(
              'Si è verificato un errore!', 'I nomi non sono uguali');
        } else {
          _showErrorDialog('Password modificata', '');
        }
      }
    }
    setState(() {
      attendi = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Gestione password'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nuova Password'),
                obscureText: true,
                //controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password troppo corta!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ripeti Password'),
                obscureText: true,
                //controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password troppo corta!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['ripetiPassword'] = value!;
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Nome primo animaletto '),
                obscureText: true,
                //controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nome obbligatorio!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['pet'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ripeti il nome'),
                obscureText: true,
                //controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nome obbligatorio!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['ripetiPet'] = value!;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: attendi ? null : () => _submit(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 8.0),
                ),
                child: const Text(
                  'Conferma',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
