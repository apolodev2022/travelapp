import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:travelapp/models/result.dart';

class DetailSearchPlacePage extends StatelessWidget {
  final Results place;

  const DetailSearchPlacePage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.name ?? "Detalle"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image.network(
                    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${place.photos?.first.photoReference}' ??
                        "",
                    errorBuilder: (BuildContext context, Object exeption,
                        StackTrace? strackTrace) {
                      return const Image(
                        image: AssetImage('assets/images/Logo.png'),
                      );
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Ciudad: ${place.vicinity}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17.0, fontStyle: FontStyle.italic))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tipo: ${place.types?.iterator}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17.0, fontStyle: FontStyle.italic)))
                ]))));
  }
}
