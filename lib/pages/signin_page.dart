import 'package:flutter/material.dart';
import 'package:travelapp/models/user.dart';
import 'package:travelapp/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:travelapp/repository/firebase_api.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  String data = 'Información';

  void _onRegisterButtonClicked() {
    setState(() {
      if (_password.text == _repPassword.text) {
        var user = User("", _name.text, _email.text, _password.text);
        _registerUser(user);
      } else {
        _showMsg(context, 'Las contraseñas deben de ser iguales');
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

  void _saveUser(User user) async {
    var result = await _firebaseApi.createUser(user);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void _registerUser(User user) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("user", jsonEncode(user));
    var result = await _firebaseApi.registerUser(user.email, user.password);
    String msg = '';
    if (result == "invalid-email") {
      msg = "El correo electrónico está mal escrito";
    } else if (result == "weak-password") {
      msg = "La contraseña debe tener mínimo 6 dígitos";
    } else if (result == "email-already-in-use") {
      msg = "Ya existe una cuenta con ese correo electrónico";
    } else if (result == "network-required-failed") {
      msg = "Revise su conexión a Internet";
    } else if (result == "unknown") {
      msg = "Debe completar todos los campos";
    } else {
      msg = "Usuario registrado con éxito";
      user.uid = result;
      _saveUser(user);
    }
    _showMsg(context, msg);
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
