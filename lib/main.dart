import 'package:flutter/material.dart';
import 'package:travelapp/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8),
  //       child: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Image.asset(
  //               'assets/images/Logo.png',
  //               fit: BoxFit.contain,
  //               height: 300,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }