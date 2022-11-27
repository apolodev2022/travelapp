import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelapp/pages/detail_page.dart';
import 'package:travelapp/pages/home_page.dart';
import 'package:travelapp/pages/login_page.dart';
import 'package:travelapp/pages/place_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _closeSplash();
    // Timer(
    //     Duration(seconds: 5),
    //     () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        margin: const EdgeInsets.all(30),
        child: const Center(
          child: Image(image: AssetImage('assets/images/Logo.png')),
        ),
      ),
    );
  }

  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 2), () async {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        Navigator.of(context).pushReplacement(PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 2000),
          child: const LoginPage(),
        ));
      } else {
        Navigator.of(context).pushReplacement(PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 2000),
          child: const HomePage(),
        ));
      }
    });
  }
}
