import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelapp/pages/login_page.dart';

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
      data = "Nombre: ${_name.text} \nEmail: ${_email.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Center(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage('assets/images/Logo.png'),
                    height: 300,
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
