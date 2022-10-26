import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelapp/pages/login_page.dart';

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
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: Image(image: AssetImage('assets/images/Logo.png')),
        ),
      ),
    );
  }

  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 2000),
        child: LoginPage(),
      ));
    });
  }
}
