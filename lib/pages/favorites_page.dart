import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travelapp/boxes.dart';
import 'package:travelapp/models/local_place.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Center(
        child: _buildListView(),
      ),
    ));
  }

  Widget _buildListView() {
    return ValueListenableBuilder<Box<LocalPlace>>(
        valueListenable: Boxes.getFavoritesBox().listenable(),
        builder: (context, box, _) {
          final placeBox = box.values.toList().cast<LocalPlace>();
          return ListView.builder(
              itemCount: placeBox.length,
              itemBuilder: (BuildContext context, int index) {
                final place = placeBox[index];
                return Card(
                    child: ListTile(
                  leading: Image.network(
                    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${place.imageLink}' ??
                        "",
                    errorBuilder: (BuildContext context, Object exeption,
                        StackTrace? strackTrace) {
                      return const Image(
                        image: AssetImage('assets/images/Logo.png'),
                      );
                    },
                  ),
                  title: Text(place.name ?? "No title"),
                  subtitle: Text(place.city ?? "No vicinity"),
                  onLongPress: () {
                    setState(() {
                      place.delete();
                    });
                  },
                ));
              });
        });
  }
}
