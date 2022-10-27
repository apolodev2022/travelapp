import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ciudad = 'XXX';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Detaile Sitio Turistico POI',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Detaile Sitio Turistico POI'),
            ),
            body: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(children: <Widget>[
                  const Text(
                    'Nombre POI',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Image(
                    image: AssetImage('assets/images/image.png'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Ciudad: XXXX\nDepartamento: XXXX\nTemperatura: XXXX",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Descripción: Sed ut perspicatis, unde omnis iste natus error sit voluptatem accusant doloremque laudantium, totam rem apertam esque ipsa, que ab illo inventore veritatis.',
                        style: TextStyle(fontSize: 16),
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: const Text('Otra información de interés.',
                          style: TextStyle(fontSize: 16)))
                ]))));
  }
}
