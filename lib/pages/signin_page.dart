import 'package:flutter/material.dart';
import 'package:travelapp/models/User.dart';
import 'package:travelapp/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  String data = 'Información';

  void _onRegisterButtonClicked() {
    setState(() {
      if (_password.text == _repPassword.text) {
        var user = User(_name.text, _email.text, _password.text);
        saveUser(user);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        _showMsg(context, 'Las constraseñás deben de ser iguales');
      }
    });
  }

  void _showMsg(BuildContext context, String msg) {
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(
      SnackBar(
          content: Text(msg),
          action: SnackBarAction(
              label: 'Aceptar', onPressed: Scaffold.hideCurrentSnackBar)),
    );
  }

  void saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage('assets/images/Logo.png'),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre',
                      ),
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo electrónico',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _repPassword,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Repita la contraseña'),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        _onRegisterButtonClicked();
                      },
                      child: const Text("Registrar")),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text('Iniciar sesión'),
                  ),
                  Text(
                    data,
                    style: const TextStyle(
                        fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              )),
            )));
  }
}
