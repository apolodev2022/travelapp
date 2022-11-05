import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/models/user.dart';
import 'package:travelapp/pages/place_page.dart';
import 'package:travelapp/pages/signin_page.dart';
import 'package:travelapp/repository/firebase_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  final _email = TextEditingController();
  final _password = TextEditingController();

  User userLoad = User.Empty();

  @override
  void initState() {
    // getUser();
    super.initState();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    userLoad = User.fromJson(userMap);
  }

  void _showMsg(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: 'Aceptar', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _validateUser() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showMsg(context, "Debe ingresar el correo y la contraseña");
    } else {
      var result = await _firebaseApi.loginUser(_email.text, _password.text);
      String msg = "";
      if (result == "invalid-email") {
        msg = "El correo electrónico está mal escrito";
      } else if (result == "wrong-password") {
        msg = "Correo o contraseña incorrectos";
      } else if (result == "network-required-failed") {
        msg = "Revise su conexión a Internet";
      } else {
        msg = "Bienvenido";
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PlacePage()));
      }
      _showMsg(context, msg);
    }
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
            controller: _email,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Correo electrónico'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            controller: _password,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Password'),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                _validateUser();
              },
              child: const Text('Iniciar sesión')),
          TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue)),
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
            child: const Text('Registrarse'),
          ),
        ],
      ))),
    ));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SigninPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
