import 'package:flutter/material.dart';
import 'package:travelapp/pages/signin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

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
              onPressed: () {},
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
