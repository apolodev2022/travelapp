import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travelapp/models/local_place.dart';
import 'package:travelapp/pages/detail_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(LocalPlaceAdapter());

  await Hive.openBox<LocalPlace>('favorites');

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
      home: const DetailPage(),
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